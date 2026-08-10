class ActivityModel {
  final String id;
  final String action;
  final String performedBy;
  final String performedByName;
  final String? targetId;
  final String? targetName;
  final DateTime timestamp;
  final Map<String, dynamic>? details;

  const ActivityModel({
    required this.id,
    required this.action,
    required this.performedBy,
    required this.performedByName,
    this.targetId,
    this.targetName,
    required this.timestamp,
    this.details,
  });

  /// Creates an [ActivityModel] from a Firestore document map.
  /// The document ID must be embedded in [map] under the key `'id'`.
  factory ActivityModel.fromMap(Map<String, dynamic> map) {
    return ActivityModel(
      id: map['id'] as String? ?? '',
      action: map['action'] as String? ?? '',
      performedBy: map['performedBy'] as String? ?? '',
      performedByName: map['performedByName'] as String? ?? '',
      targetId: map['targetId'] as String?,
      targetName: map['targetName'] as String?,
      timestamp: map['timestamp'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['timestamp'] as int)
          : DateTime.now(),
      details: map['details'] != null
          ? Map<String, dynamic>.from(map['details'] as Map)
          : null,
    );
  }

  /// Converts this model to a map suitable for Firestore storage.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'action': action,
      'performedBy': performedBy,
      'performedByName': performedByName,
      'targetId': targetId,
      'targetName': targetName,
      'timestamp': timestamp.millisecondsSinceEpoch,
      'details': details,
    };
  }

  /// Returns a copy of this model with the given fields replaced.
  ActivityModel copyWith({
    String? id,
    String? action,
    String? performedBy,
    String? performedByName,
    Object? targetId = _sentinel,
    Object? targetName = _sentinel,
    DateTime? timestamp,
    Object? details = _sentinel,
  }) {
    return ActivityModel(
      id: id ?? this.id,
      action: action ?? this.action,
      performedBy: performedBy ?? this.performedBy,
      performedByName: performedByName ?? this.performedByName,
      targetId: targetId == _sentinel ? this.targetId : targetId as String?,
      targetName:
          targetName == _sentinel ? this.targetName : targetName as String?,
      timestamp: timestamp ?? this.timestamp,
      details: details == _sentinel
          ? this.details
          : details as Map<String, dynamic>?,
    );
  }

  /// Returns a human-readable relative time string for [timestamp], such as
  /// "just now", "5 minutes ago", "2 hours ago", or "3 days ago".
  String get timeAgo {
    final now = DateTime.now();
    final diff = now.difference(timestamp);

    if (diff.inSeconds < 60) {
      return 'just now';
    } else if (diff.inMinutes < 60) {
      final m = diff.inMinutes;
      return '$m ${m == 1 ? 'minute' : 'minutes'} ago';
    } else if (diff.inHours < 24) {
      final h = diff.inHours;
      return '$h ${h == 1 ? 'hour' : 'hours'} ago';
    } else if (diff.inDays < 7) {
      final d = diff.inDays;
      return '$d ${d == 1 ? 'day' : 'days'} ago';
    } else if (diff.inDays < 30) {
      final w = (diff.inDays / 7).floor();
      return '$w ${w == 1 ? 'week' : 'weeks'} ago';
    } else if (diff.inDays < 365) {
      final mo = (diff.inDays / 30).floor();
      return '$mo ${mo == 1 ? 'month' : 'months'} ago';
    } else {
      final y = (diff.inDays / 365).floor();
      return '$y ${y == 1 ? 'year' : 'years'} ago';
    }
  }

  @override
  String toString() =>
      'ActivityModel(id: $id, action: $action, performedBy: $performedByName)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActivityModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

const Object _sentinel = Object();
