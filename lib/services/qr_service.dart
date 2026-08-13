import 'dart:convert';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import '../models/visitor_model.dart';

class QrService {
  QrService();
  static final QrService instance = QrService();

  final FirebaseStorage _storage = FirebaseStorage.instance;

  String generateQrData(VisitorModel visitor) {
    final payload = {
      'id': visitor.id,
      'name': visitor.name,
      'apartmentNo': visitor.apartmentNo,
      'hostId': visitor.hostId,
      'validUntil': visitor.validUntil.toIso8601String(),
      'generatedAt': DateTime.now().toIso8601String(),
    };
    return jsonEncode(payload);
  }

  Future<String> saveQrToStorage(String visitorId, String qrData) async {
    try {
      final qrValidationResult = QrValidator.validate(
        data: qrData,
        version: QrVersions.auto,
        errorCorrectionLevel: QrErrorCorrectLevel.M,
      );

      if (!qrValidationResult.isValid) {
        throw Exception('QrService: invalid QR data for visitor $visitorId');
      }

      final qrCode = qrValidationResult.qrCode!;
      final painter = QrPainter.withQr(
        qr: qrCode,
        color: const Color(0xFF000000),
        emptyColor: const Color(0xFFFFFFFF),
        gapless: true,
      );

      final pictureRecorder = ui.PictureRecorder();
      final canvas = Canvas(pictureRecorder);
      const size = Size(300, 300);
      painter.paint(canvas, size);
      final picture = pictureRecorder.endRecording();
      final img = await picture.toImage(300, 300);
      final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
      final pngBytes = byteData!.buffer.asUint8List();

      final ref = _storage.ref('visitors/qr/$visitorId.png');
      final uploadTask = await ref.putData(
        pngBytes,
        SettableMetadata(contentType: 'image/png'),
      );
      final downloadUrl = await uploadTask.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      debugPrint('QrService.saveQrToStorage error: $e');
      rethrow;
    }
  }

  bool isValidQrData(String qrData) {
    try {
      final map = parseQrData(qrData);
      if (map == null) return false;
      const requiredKeys = ['id', 'name', 'apartmentNo', 'validUntil'];
      return requiredKeys.every((k) => map.containsKey(k) && map[k] != null);
    } catch (_) {
      return false;
    }
  }

  Map<String, dynamic>? parseQrData(String qrData) {
    try {
      final decoded = jsonDecode(qrData);
      if (decoded is Map<String, dynamic>) return decoded;
      return null;
    } catch (e) {
      debugPrint('QrService.parseQrData error: $e');
      return null;
    }
  }
}
