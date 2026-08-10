import '../../models/notification_model.dart';
import '../../services/firestore_service.dart';

class NotificationRepository {
  final FirestoreService _firestoreService = FirestoreService();

  Future<void> createNotification(NotificationModel notification) async {
    await _firestoreService.add('notifications', notification.id, notification.toMap());
  }

  Future<void> markAsRead(String notificationId) async {
    await _firestoreService.update('notifications', notificationId, {'isRead': true});
  }
}
