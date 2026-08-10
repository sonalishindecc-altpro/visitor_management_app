import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class StorageService {
  StorageService();
  static final StorageService instance = StorageService();

  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String?> uploadVisitorPhoto(File imageFile, String visitorId) async {
    try {
      final ext = imageFile.path.split('.').last;
      final ref = _storage.ref('visitors/photos/$visitorId.$ext');
      final snapshot = await ref.putFile(
        imageFile,
        SettableMetadata(contentType: 'image/$ext'),
      );
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      debugPrint('StorageService.uploadVisitorPhoto error: $e');
      return null;
    }
  }

  Future<String?> uploadProfilePhoto(File imageFile, String userId) async {
    try {
      final ext = imageFile.path.split('.').last;
      final ref = _storage.ref('users/photos/$userId.$ext');
      final snapshot = await ref.putFile(
        imageFile,
        SettableMetadata(contentType: 'image/$ext'),
      );
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      debugPrint('StorageService.uploadProfilePhoto error: $e');
      return null;
    }
  }

  Future<void> deleteFile(String url) async {
    try {
      final ref = _storage.refFromURL(url);
      await ref.delete();
    } catch (e) {
      debugPrint('StorageService.deleteFile error: $e');
      rethrow;
    }
  }
}
