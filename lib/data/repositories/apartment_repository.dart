import '../../models/apartment_model.dart';
import '../../services/firestore_service.dart';

class ApartmentRepository {
  final FirestoreService _firestoreService = FirestoreService();

  Future<List<ApartmentModel>> getAllApartments() async {
    final snapshot = await _firestoreService.streamCollection('apartments').first;
    return snapshot.docs
        .map((doc) => ApartmentModel.fromMap(doc.data()))
        .toList();
  }

  Future<void> createApartment(ApartmentModel apartment) async {
    await _firestoreService.add('apartments', apartment.id, apartment.toMap());
  }

  Future<void> updateApartment(ApartmentModel apartment) async {
    await _firestoreService.update('apartments', apartment.id, apartment.toMap());
  }

  Future<void> deleteApartment(String id) async {
    await _firestoreService.delete('apartments', id);
  }
}
