import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../models/visitor_model.dart';
import '../models/activity_model.dart';

class FirestoreService {
  FirestoreService();
  static final FirestoreService instance = FirestoreService();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ---------------------------------------------------------------------------
  // Collection name constants
  // ---------------------------------------------------------------------------

  static const String _users = 'users';
  static const String _visitors = 'visitors';
  static const String _apartments = 'apartments';
  static const String _notifications = 'notifications';
  static const String _activities = 'activities';

  // ---------------------------------------------------------------------------
  // Generic CRUD
  // ---------------------------------------------------------------------------

  /// Adds / overwrites a document identified by [id] inside [collection].
  Future<void> add(String collection, String id, Map<String, dynamic> data) async {
    try {
      await _db.collection(collection).doc(id).set(data);
    } catch (e) {
      debugPrint('FirestoreService.add [$collection/$id] error: \$e');
      rethrow;
    }
  }

  /// Merges [data] into the existing document at [collection]/[id].
  Future<void> update(String collection, String id, Map<String, dynamic> data) async {
    try {
      await _db.collection(collection).doc(id).update(data);
    } catch (e) {
      debugPrint('FirestoreService.update [$collection/$id] error: \$e');
      rethrow;
    }
  }

  /// Deletes the document at [collection]/[id].
  Future<void> delete(String collection, String id) async {
    try {
      await _db.collection(collection).doc(id).delete();
    } catch (e) {
      debugPrint('FirestoreService.delete [$collection/$id] error: \$e');
      rethrow;
    }
  }

  /// Returns the raw data map for [collection]/[id], or `null` if not found.
  Future<Map<String, dynamic>?> get(String collection, String id) async {
    try {
      final doc = await _db.collection(collection).doc(id).get();
      return doc.data();
    } catch (e) {
      debugPrint('FirestoreService.get [$collection/$id] error: \$e');
      return null;
    }
  }

  /// Streams all documents in [collection].
  /// Optionally filter by supplying [whereField], [isEqualTo], etc. through
  /// the caller building a query externally – or use the dedicated helpers below.
  Stream<QuerySnapshot<Map<String, dynamic>>> streamCollection(String collection) {
    try {
      return _db.collection(collection).snapshots();
    } catch (e) {
      debugPrint('FirestoreService.streamCollection [$collection] error: \$e');
      return const Stream.empty();
    }
  }

  // ---------------------------------------------------------------------------
  // Visitor-specific streams / queries
  // ---------------------------------------------------------------------------

  /// Streams visitors whose [visitDate] matches today's date.
  Stream<List<VisitorModel>> streamTodayVisitors() {
    try {
      final today = DateTime.now();
      final startOfDay = DateTime(today.year, today.month, today.day);
      final endOfDay = startOfDay.add(const Duration(days: 1));

      return _db
          .collection(_visitors)
          .where('visitDate',
              isGreaterThanOrEqualTo: startOfDay.toIso8601String())
          .where('visitDate', isLessThan: endOfDay.toIso8601String())
          .orderBy('visitDate', descending: true)
          .snapshots()
          .map((snap) =>
              snap.docs.map((d) => VisitorModel.fromMap(d.data())).toList());
    } catch (e) {
      debugPrint('FirestoreService.streamTodayVisitors error: \$e');
      return const Stream.empty();
    }
  }

  /// Streams visitors with status == 'pending' for a given [hostId].
  Stream<List<VisitorModel>> streamPendingVisitors(String hostId) {
    try {
      return _db
          .collection(_visitors)
          .where('hostId', isEqualTo: hostId)
          .where('status', isEqualTo: 'pending')
          .orderBy('visitDate', descending: true)
          .snapshots()
          .map((snap) =>
              snap.docs.map((d) => VisitorModel.fromMap(d.data())).toList());
    } catch (e) {
      debugPrint('FirestoreService.streamPendingVisitors error: \$e');
      return const Stream.empty();
    }
  }

  /// Fetches visitor history filtered by optional [hostId], [from], and [to].
  Future<List<VisitorModel>> getVisitorHistory(
    String? hostId, {
    DateTime? from,
    DateTime? to,
  }) async {
    try {
      Query<Map<String, dynamic>> query = _db.collection(_visitors);

      if (hostId != null) {
        query = query.where('hostId', isEqualTo: hostId);
      }
      if (from != null) {
        query = query.where('visitDate',
            isGreaterThanOrEqualTo: from.toIso8601String());
      }
      if (to != null) {
        query = query.where('visitDate',
            isLessThanOrEqualTo: to.toIso8601String());
      }

      query = query.orderBy('visitDate', descending: true);

      final snap = await query.get();
      return snap.docs.map((d) => VisitorModel.fromMap(d.data())).toList();
    } catch (e) {
      debugPrint('FirestoreService.getVisitorHistory error: \$e');
      return [];
    }
  }

  // ---------------------------------------------------------------------------
  // Activity logging
  // ---------------------------------------------------------------------------

  /// Writes an [ActivityModel] to the [activities] collection.
  Future<void> logActivity(ActivityModel activity) async {
    try {
      final data = activity.toMap();
      await _db
          .collection(_activities)
          .doc(activity.id)
          .set(data);
    } catch (e) {
      debugPrint('FirestoreService.logActivity error: \$e');
      rethrow;
    }
  }
}
