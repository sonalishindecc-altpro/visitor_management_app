import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../models/user_model.dart';

class AuthService extends ChangeNotifier {
  UserModel? _currentUser;
  bool _isLoading = true; // Start as true while checking initial auth state

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AuthService() {
    _init();
  }

  void _init() {
    _auth.authStateChanges().listen((User? user) async {
      if (user != null) {
        await _loadUserData(user.uid);
      } else {
        _currentUser = null;
        _isLoading = false;
        notifyListeners();
      }
    });
  }

  // ---------------------------------------------------------------------------
  // Getters
  // ---------------------------------------------------------------------------

  UserModel? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;
  bool get isLoading => _isLoading;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // ---------------------------------------------------------------------------
  // Sign In
  // ---------------------------------------------------------------------------

  /// Signs in with [email] and [password].
  /// Returns `true` on success, `false` on failure.
  Future<bool> signIn(String email, String password) async {
    _setLoading(true);
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      final uid = credential.user?.uid;
      if (uid == null) return false;
      await _loadUserData(uid);
      return _currentUser != null;
    } on FirebaseAuthException catch (e) {
      debugPrint('AuthService.signIn FirebaseAuthException: ${e.code} – ${e.message}');
      return false;
    } catch (e) {
      debugPrint('AuthService.signIn error: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // ---------------------------------------------------------------------------
  // Register
  // ---------------------------------------------------------------------------

  /// Creates a new Firebase Auth user and writes their profile to Firestore.
  /// Returns `true` on success.
  Future<bool> register({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String role,
    required String apartmentId,
  }) async {
    _setLoading(true);
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      final uid = credential.user?.uid;
      if (uid == null) return false;

      // Update display name on the Auth profile.
      await credential.user?.updateDisplayName(name);

      final now = DateTime.now();
      final userData = <String, dynamic>{
        'uid': uid,
        'name': name,
        'email': email.trim(),
        'phone': phone,
        'role': role,
        'apartmentId': apartmentId,
        'createdAt': now.millisecondsSinceEpoch,
        'updatedAt': now.millisecondsSinceEpoch,
        'isActive': true,
        'photoUrl': '',
      };

      await _firestore.collection('users').doc(uid).set(userData);

      _currentUser = UserModel.fromMap(userData, uid);
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      debugPrint('AuthService.register FirebaseAuthException: ${e.code} – ${e.message}');
      return false;
    } catch (e) {
      debugPrint('AuthService.register error: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // ---------------------------------------------------------------------------
  // Sign Out
  // ---------------------------------------------------------------------------

  Future<void> signOut() async {
    _setLoading(true);
    try {
      await _auth.signOut();
      _currentUser = null;
      notifyListeners();
    } catch (e) {
      debugPrint('AuthService.signOut error: $e');
    } finally {
      _setLoading(false);
    }
  }

  // ---------------------------------------------------------------------------
  // Delete Account
  // ---------------------------------------------------------------------------

  /// Deletes the current user's document from Firestore and their account from Firebase Auth.
  Future<bool> deleteAccount() async {
    final user = _auth.currentUser;
    if (user == null) return false;

    _setLoading(true);
    try {
      // 1. Delete Firestore data
      await _firestore.collection('users').doc(user.uid).delete();
      
      // 2. Delete Auth account
      await user.delete();
      
      _currentUser = null;
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      debugPrint('AuthService.deleteAccount FirebaseAuthException: ${e.code} – ${e.message}');
      // Note: If e.code == 'requires-recent-login', the UI should handle re-authentication
      rethrow;
    } catch (e) {
      debugPrint('AuthService.deleteAccount error: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // ---------------------------------------------------------------------------
  // Password Reset
  // ---------------------------------------------------------------------------

  Future<void> sendPasswordResetEmail(String email) async {
    _setLoading(true);
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
    } on FirebaseAuthException catch (e) {
      debugPrint('AuthService.sendPasswordResetEmail error: ${e.code} – ${e.message}');
      rethrow;
    } catch (e) {
      debugPrint('AuthService.sendPasswordResetEmail error: $e');
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  // ---------------------------------------------------------------------------
  // Internal helpers
  // ---------------------------------------------------------------------------

  /// Fetches the user document from Firestore and caches it in [_currentUser].
  Future<void> _loadUserData(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists && doc.data() != null) {
        _currentUser = UserModel.fromMap(doc.data()!, uid);
      } else {
        debugPrint('AuthService._loadUserData: no document found for uid=$uid');
        _currentUser = null;
      }
    } catch (e) {
      debugPrint('AuthService._loadUserData error: $e');
      _currentUser = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
