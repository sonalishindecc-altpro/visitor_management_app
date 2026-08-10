import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:uuid/uuid.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('NotificationService background message: ${message.messageId}');
}

class NotificationService {
  NotificationService();
  static final NotificationService instance = NotificationService();

  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? _fcmToken;

  String? get fcmToken => _fcmToken;

  Future<void> initialize() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    try {
      await _fcm.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );
    } catch (e) {
      debugPrint('NotificationService FCM permission error: $e');
    }

    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    try {
      await _localNotifications.initialize(
        initSettings,
        onDidReceiveNotificationResponse: _onNotificationResponse,
      );
    } catch (e) {
      debugPrint('NotificationService local notifications error: $e');
    }

    const androidChannel = AndroidNotificationChannel(
      'vsms_channel',
      'Visitor Management',
      description: 'Notifications for visitor events',
      importance: Importance.high,
    );
    try {
      await _localNotifications
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(androidChannel);
    } catch (e) {
      debugPrint('NotificationService channel creation error: $e');
    }

    await _refreshFcmToken();
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
  }

  Future<void> showNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    try {
      const androidDetails = AndroidNotificationDetails(
        'vsms_channel',
        'Visitor Management',
        channelDescription: 'Notifications for visitor events',
        importance: Importance.high,
        priority: Priority.high,
        showWhen: true,
      );
      const iosDetails = DarwinNotificationDetails();
      const details = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );
      await _localNotifications.show(
        DateTime.now().millisecondsSinceEpoch ~/ 1000,
        title,
        body,
        details,
        payload: payload,
      );
    } catch (e) {
      debugPrint('NotificationService.showNotification error: $e');
    }
  }

  Future<void> cancelAll() async {
    try {
      await _localNotifications.cancelAll();
    } catch (e) {
      debugPrint('NotificationService.cancelAll error: $e');
    }
  }

  Future<void> sendPushToUser(
      String userId, String title, String body) async {
    try {
      final id = const Uuid().v4();
      await _firestore.collection('notifications').doc(id).set({
        'id': id,
        'targetUserId': userId,
        'title': title,
        'body': body,
        'status': 'pending',
        'createdAt': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      debugPrint('NotificationService.sendPushToUser error: $e');
      rethrow;
    }
  }

  Future<void> _refreshFcmToken() async {
    try {
      _fcmToken = await _fcm.getToken();
      _fcm.onTokenRefresh.listen((newToken) {
        _fcmToken = newToken;
      });
    } catch (e) {
      debugPrint('NotificationService._refreshFcmToken error: $e');
    }
  }

  void _handleForegroundMessage(RemoteMessage message) {
    final notification = message.notification;
    if (notification == null) return;
    showNotification(
      title: notification.title ?? 'Visitor Management',
      body: notification.body ?? '',
      payload: jsonEncode(message.data),
    );
  }

  void _onNotificationResponse(NotificationResponse response) {
    debugPrint('NotificationService payload=${response.payload}');
  }
}
