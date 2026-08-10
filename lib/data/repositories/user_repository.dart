import '../../models/user_model.dart';
import '../../services/firestore_service.dart';

class UserRepository {
  final FirestoreService _firestoreService = FirestoreService();

  Future<UserModel?> getUserById(String uid) async {
    final data = await _firestoreService.get('users', uid);
    if (data != null) {
      return UserModel.fromMap(data, uid);
    }
    return null;
  }

  Future<List<UserModel>> getAllUsers() async {
    final snapshot = await _firestoreService.streamCollection('users').first;
    return snapshot.docs
        .map((doc) => UserModel.fromMap(doc.data(), doc.id))
        .toList();
  }

  Future<List<UserModel>> getUsersByRole(UserRole role) async {
    final users = await getAllUsers();
    return users.where((u) => u.role == role).toList();
  }

  Future<void> createUser(UserModel user) async {
    await _firestoreService.add('users', user.uid, user.toMap());
  }

  Future<void> updateUser(UserModel user) async {
    await _firestoreService.update('users', user.uid, user.toMap());
  }

  Future<void> deleteUser(String uid) async {
    await _firestoreService.delete('users', uid);
  }
}
