enum NotificationType {
  visitorArrival,
  visitorApproved,
  visitorDenied,
  visitorCheckedOut,
  system,
}

class NotificationModel {
  final String id;
  final String title;
  final String body;
  final String userId;
  final NotificationType type;
  final bool isRead;
  final DateTime createdAt;
  final Map<String, dynamic>? data;

  const NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.userId,
    required this.type,
    this.isRead = false,
    required this.createdAt,
    this.data,
  });

  /// Creates a [NotificationModel] from a Firestore document map.
  /// The document ID must be embedded in [map] under the key `'id'`.
  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['id'] as String? ?? '',
      title: map['title'] as String? ?? '',
      body: map['body'] as String? ?? '',
      userId: map['userId'] as String? ?? '',
      type: _typeFromString(map['type'] as String? ?? 'system'),
      isRead: map['isRead'] as bool? ?? false,
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int)
          : DateTime.now(),
      data: map['data'] != null
          ? Map<String, dynamic>.from(map['data'] as Map)
          : null,
    );
  }

  /// Converts this model to a map suitable for Firestore storage.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'userId': userId,
      'type': type.name,
      'isRead': isRead,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'data': data,
    };
  }

  /// Returns a copy of this model with the given fields replaced.
  NotificationModel copyWith({
    String? id,
    String? title,
    String? body,
    String? userId,
    NotificationType? type,
    bool? isRead,
    DateTime? createdAt,
    Object? data = _sentinel,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      userId: userId ?? this.userId,
      type: type ?? this.type,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt ?? this.createdAt,
      data: data == _sentinel
          ? this.data
          : data as Map<String, dynamic>?,
    );
  }

  static NotificationType _typeFromString(String value) {
    return NotificationType.values.firstWhere(
      (e) => e.name == value,
      orElse: () => NotificationType.system,
    );
  }

  @override
  String toString() =>
      'NotificationModel(id: $id, title: $title, type: $type, isRead: $isRead)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

const Object _sentinel = Object();
