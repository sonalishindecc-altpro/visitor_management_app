enum UserRole { admin, security, resident }

class UserModel {
  final String uid;
  final String name;
  final String email;
  final String phone;
  final UserRole role;
  final String? apartmentId;
  final String? photoUrl;
  final DateTime createdAt;
  final bool isActive;

  const UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    this.apartmentId,
    this.photoUrl,
    required this.createdAt,
    this.isActive = true,
  });

  /// Creates a [UserModel] from a Firestore document map plus the document [uid].
  factory UserModel.fromMap(Map<String, dynamic> map, String uid) {
    return UserModel(
      uid: uid,
      name: map['name'] as String? ?? '',
      email: map['email'] as String? ?? '',
      phone: map['phone'] as String? ?? '',
      role: _roleFromString(map['role'] as String? ?? 'resident'),
      apartmentId: map['apartmentId'] as String?,
      photoUrl: map['photoUrl'] as String?,
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int)
          : DateTime.now(),
      isActive: map['isActive'] as bool? ?? true,
    );
  }

  /// Converts this model to a map suitable for Firestore storage.
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'role': role.name,
      'apartmentId': apartmentId,
      'photoUrl': photoUrl,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'isActive': isActive,
    };
  }

  /// Returns a copy of this model with the given fields replaced.
  /// Pass `null` explicitly to clear nullable fields.
  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? phone,
    UserRole? role,
    Object? apartmentId = _sentinel,
    Object? photoUrl = _sentinel,
    DateTime? createdAt,
    bool? isActive,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      apartmentId:
          apartmentId == _sentinel ? this.apartmentId : apartmentId as String?,
      photoUrl: photoUrl == _sentinel ? this.photoUrl : photoUrl as String?,
      createdAt: createdAt ?? this.createdAt,
      isActive: isActive ?? this.isActive,
    );
  }

  /// Human-readable display name for the user's role.
  String get roleDisplayName {
    switch (role) {
      case UserRole.admin:
        return 'Administrator';
      case UserRole.security:
        return 'Security Guard';
      case UserRole.resident:
        return 'Resident';
    }
  }

  /// Returns the first letter of the first name and first letter of the last
  /// name (if present), e.g. "John Doe" → "JD", "Madonna" → "M".
  String get initials {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts.first.isEmpty) return '';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
  }

  static UserRole _roleFromString(String value) {
    return UserRole.values.firstWhere(
      (e) => e.name == value,
      orElse: () => UserRole.resident,
    );
  }

  @override
  String toString() =>
      'UserModel(uid: $uid, name: $name, email: $email, role: $role)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModel &&
          runtimeType == other.runtimeType &&
          uid == other.uid;

  @override
  int get hashCode => uid.hashCode;
}

// Sentinel object used to distinguish "not provided" from explicit null
// in copyWith nullable parameters.
const Object _sentinel = Object();
