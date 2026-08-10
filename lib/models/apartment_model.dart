class ApartmentModel {
  final String id;
  final String number;
  final String floor;
  final String block;
  final String? residentId;
  final String? residentName;
  final String? residentPhone;
  final bool isOccupied;

  const ApartmentModel({
    required this.id,
    required this.number,
    required this.floor,
    required this.block,
    this.residentId,
    this.residentName,
    this.residentPhone,
    this.isOccupied = false,
  });

  /// Creates an [ApartmentModel] from a Firestore document map.
  /// The document ID must be embedded in [map] under the key `'id'`.
  factory ApartmentModel.fromMap(Map<String, dynamic> map) {
    return ApartmentModel(
      id: map['id'] as String? ?? '',
      number: map['number'] as String? ?? '',
      floor: map['floor'] as String? ?? '',
      block: map['block'] as String? ?? '',
      residentId: map['residentId'] as String?,
      residentName: map['residentName'] as String?,
      residentPhone: map['residentPhone'] as String?,
      isOccupied: map['isOccupied'] as bool? ?? false,
    );
  }

  /// Converts this model to a map suitable for Firestore storage.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'number': number,
      'floor': floor,
      'block': block,
      'residentId': residentId,
      'residentName': residentName,
      'residentPhone': residentPhone,
      'isOccupied': isOccupied,
    };
  }

  /// Returns a copy of this model with the given fields replaced.
  ApartmentModel copyWith({
    String? id,
    String? number,
    String? floor,
    String? block,
    Object? residentId = _sentinel,
    Object? residentName = _sentinel,
    Object? residentPhone = _sentinel,
    bool? isOccupied,
  }) {
    return ApartmentModel(
      id: id ?? this.id,
      number: number ?? this.number,
      floor: floor ?? this.floor,
      block: block ?? this.block,
      residentId:
          residentId == _sentinel ? this.residentId : residentId as String?,
      residentName: residentName == _sentinel
          ? this.residentName
          : residentName as String?,
      residentPhone: residentPhone == _sentinel
          ? this.residentPhone
          : residentPhone as String?,
      isOccupied: isOccupied ?? this.isOccupied,
    );
  }

  /// A formatted display name combining the block and unit number,
  /// e.g. "Block A - 101".
  String get displayName => 'Block $block - $number';

  @override
  String toString() =>
      'ApartmentModel(id: $id, displayName: $displayName, isOccupied: $isOccupied)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ApartmentModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

const Object _sentinel = Object();
