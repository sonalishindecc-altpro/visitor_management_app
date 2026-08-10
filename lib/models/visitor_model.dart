enum VisitorStatus { pending, approved, denied, checkedOut, preRegistered }

enum VisitPurpose { delivery, guest, maintenance, business, other }

class VisitorModel {
  final String id;
  final String name;
  final String phone;
  final String purpose;
  final VisitorStatus status;
  final String hostId;
  final String hostName;
  final String apartmentId;
  final String apartmentNo;
  final DateTime checkInTime;
  final DateTime? checkOutTime;
  final DateTime? approvedAt;
  final String? photoUrl;
  final String? qrCode;
  final String? vehicleNumber;
  final String? notes;
  final bool isPreRegistered;
  final String createdBy;

  const VisitorModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.purpose,
    required this.status,
    required this.hostId,
    required this.hostName,
    required this.apartmentId,
    required this.apartmentNo,
    required this.checkInTime,
    this.checkOutTime,
    this.approvedAt,
    this.photoUrl,
    this.qrCode,
    this.vehicleNumber,
    this.notes,
    this.isPreRegistered = false,
    required this.createdBy,
  });

  /// Creates a [VisitorModel] from a Firestore document map.
  /// The document ID must be embedded in [map] under the key `'id'`.
  factory VisitorModel.fromMap(Map<String, dynamic> map) {
    return VisitorModel(
      id: map['id'] as String? ?? '',
      name: map['name'] as String? ?? '',
      phone: map['phone'] as String? ?? '',
      purpose: map['purpose'] as String? ?? '',
      status: _statusFromString(map['status'] as String? ?? 'pending'),
      hostId: map['hostId'] as String? ?? '',
      hostName: map['hostName'] as String? ?? '',
      apartmentId: map['apartmentId'] as String? ?? '',
      apartmentNo: map['apartmentNo'] as String? ?? '',
      checkInTime: map['checkInTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['checkInTime'] as int)
          : DateTime.now(),
      checkOutTime: map['checkOutTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['checkOutTime'] as int)
          : null,
      approvedAt: map['approvedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['approvedAt'] as int)
          : null,
      photoUrl: map['photoUrl'] as String?,
      qrCode: map['qrCode'] as String?,
      vehicleNumber: map['vehicleNumber'] as String?,
      notes: map['notes'] as String?,
      isPreRegistered: map['isPreRegistered'] as bool? ?? false,
      createdBy: map['createdBy'] as String? ?? '',
    );
  }

  /// Converts this model to a map suitable for Firestore storage.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'purpose': purpose,
      'status': status.name,
      'hostId': hostId,
      'hostName': hostName,
      'apartmentId': apartmentId,
      'apartmentNo': apartmentNo,
      'checkInTime': checkInTime.millisecondsSinceEpoch,
      'checkOutTime': checkOutTime?.millisecondsSinceEpoch,
      'approvedAt': approvedAt?.millisecondsSinceEpoch,
      'photoUrl': photoUrl,
      'qrCode': qrCode,
      'vehicleNumber': vehicleNumber,
      'notes': notes,
      'isPreRegistered': isPreRegistered,
      'createdBy': createdBy,
    };
  }

  /// Returns a copy of this model with the given fields replaced.
  VisitorModel copyWith({
    String? id,
    String? name,
    String? phone,
    String? purpose,
    VisitorStatus? status,
    String? hostId,
    String? hostName,
    String? apartmentId,
    String? apartmentNo,
    DateTime? checkInTime,
    Object? checkOutTime = _sentinel,
    Object? approvedAt = _sentinel,
    Object? photoUrl = _sentinel,
    Object? qrCode = _sentinel,
    Object? vehicleNumber = _sentinel,
    Object? notes = _sentinel,
    bool? isPreRegistered,
    String? createdBy,
  }) {
    return VisitorModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      purpose: purpose ?? this.purpose,
      status: status ?? this.status,
      hostId: hostId ?? this.hostId,
      hostName: hostName ?? this.hostName,
      apartmentId: apartmentId ?? this.apartmentId,
      apartmentNo: apartmentNo ?? this.apartmentNo,
      checkInTime: checkInTime ?? this.checkInTime,
      checkOutTime: checkOutTime == _sentinel
          ? this.checkOutTime
          : checkOutTime as DateTime?,
      approvedAt:
          approvedAt == _sentinel ? this.approvedAt : approvedAt as DateTime?,
      photoUrl: photoUrl == _sentinel ? this.photoUrl : photoUrl as String?,
      qrCode: qrCode == _sentinel ? this.qrCode : qrCode as String?,
      vehicleNumber: vehicleNumber == _sentinel
          ? this.vehicleNumber
          : vehicleNumber as String?,
      notes: notes == _sentinel ? this.notes : notes as String?,
      isPreRegistered: isPreRegistered ?? this.isPreRegistered,
      createdBy: createdBy ?? this.createdBy,
    );
  }

  /// Human-readable display name for the visitor's current status.
  DateTime get visitDate => checkInTime;
  DateTime get validUntil => checkInTime.add(const Duration(hours: 12));

  String get statusDisplayName {
    switch (status) {
      case VisitorStatus.pending:
        return 'Pending';
      case VisitorStatus.approved:
        return 'Approved';
      case VisitorStatus.denied:
        return 'Denied';
      case VisitorStatus.checkedOut:
        return 'Checked Out';
      case VisitorStatus.preRegistered:
        return 'Pre-Registered';
    }
  }

  /// Human-readable display name for the visit purpose.
  String get purposeDisplayName {
    final parsed = VisitPurpose.values.firstWhere(
      (e) => e.name == purpose,
      orElse: () => VisitPurpose.other,
    );
    switch (parsed) {
      case VisitPurpose.delivery:
        return 'Delivery';
      case VisitPurpose.guest:
        return 'Guest';
      case VisitPurpose.maintenance:
        return 'Maintenance';
      case VisitPurpose.business:
        return 'Business';
      case VisitPurpose.other:
        return 'Other';
    }
  }

  /// Duration of the visit. Returns `null` if the visitor has not yet checked
  /// out.
  Duration? get visitDuration {
    if (checkOutTime == null) return null;
    return checkOutTime!.difference(checkInTime);
  }

  /// Whether the visitor is currently inside (status is [VisitorStatus.approved]).
  bool get isActive => status == VisitorStatus.approved;

  static VisitorStatus _statusFromString(String value) {
    return VisitorStatus.values.firstWhere(
      (e) => e.name == value,
      orElse: () => VisitorStatus.pending,
    );
  }

  @override
  String toString() =>
      'VisitorModel(id: $id, name: $name, status: $status)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VisitorModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

const Object _sentinel = Object();
