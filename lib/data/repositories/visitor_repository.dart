import '../../models/visitor_model.dart';
import '../../services/firestore_service.dart';

class VisitorRepository {
  final FirestoreService _firestoreService = FirestoreService();

  Future<void> addVisitor(VisitorModel visitor) async {
    await _firestoreService.add('visitors', visitor.id, visitor.toMap());
  }

  Future<void> updateVisitorStatus(String visitorId, VisitorStatus status) async {
    await _firestoreService.update('visitors', visitorId, {
      'status': status.name,
      if (status == VisitorStatus.checkedOut) 'checkOutTime': DateTime.now().toIso8601String(),
    });
  }

  Stream<List<VisitorModel>> streamTodayVisitors() {
    return _firestoreService.streamTodayVisitors();
  }

  Stream<List<VisitorModel>> streamPendingVisitors(String hostId) {
    return _firestoreService.streamPendingVisitors(hostId);
  }

  Future<List<VisitorModel>> getVisitorHistory(String? hostId) async {
    return _firestoreService.getVisitorHistory(hostId);
  }
}
