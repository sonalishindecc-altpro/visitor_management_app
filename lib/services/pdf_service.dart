import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../models/visitor_model.dart';

class PdfService {
  PdfService();
  static final PdfService instance = PdfService();

  Future<Uint8List> generateVisitorReport(
    List<VisitorModel> visitors, {
    DateTime? from,
    DateTime? to,
  }) async {
    final pdf = pw.Document(
      title: 'Visitor Report',
      author: 'Visitor Security Management System',
    );

    final dateFormat = DateFormat('dd MMM yyyy');
    final timeFormat = DateFormat('hh:mm a');
    final now = DateTime.now();

    final total = visitors.length;
    final approved = visitors.where((v) => v.status == VisitorStatus.approved).length;
    final pending = visitors.where((v) => v.status == VisitorStatus.pending).length;
    final rejected = visitors.where((v) => v.status == VisitorStatus.denied).length;
    final checkedIn = visitors.length;
    final checkedOut = visitors.where((v) => v.checkOutTime != null).length;

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.symmetric(horizontal: 32, vertical: 40),
        header: (ctx) => _buildHeader(ctx, from, to, dateFormat, now),
        footer: (ctx) => _buildFooter(ctx, now),
        build: (ctx) => [
          _buildSummaryBox(
            total: total,
            approved: approved,
            pending: pending,
            rejected: rejected,
            checkedIn: checkedIn,
            checkedOut: checkedOut,
          ),
          pw.SizedBox(height: 20),
          _buildVisitorTable(visitors, dateFormat, timeFormat),
        ],
      ),
    );

    return pdf.save();
  }

  Future<void> printReport(Uint8List pdfData) async {
    try {
      await Printing.layoutPdf(
        onLayout: (_) async => pdfData,
        name: 'Visitor Report',
      );
    } catch (e) {
      debugPrint('PdfService.printReport error: $e');
      rethrow;
    }
  }

  Future<String> saveReport(Uint8List pdfData, String filename) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final reportsDir = Directory('${dir.path}/reports');
      if (!reportsDir.existsSync()) {
        reportsDir.createSync(recursive: true);
      }
      final file = File('${reportsDir.path}/$filename');
      await file.writeAsBytes(pdfData);
      return file.path;
    } catch (e) {
      debugPrint('PdfService.saveReport error: $e');
      rethrow;
    }
  }

  pw.Widget _buildHeader(
    pw.Context ctx,
    DateTime? from,
    DateTime? to,
    DateFormat dateFormat,
    DateTime now,
  ) {
    String range = 'All time';
    if (from != null && to != null) {
      range = '${dateFormat.format(from)} – ${dateFormat.format(to)}';
    } else if (from != null) {
      range = 'From ${dateFormat.format(from)}';
    } else if (to != null) {
      range = 'Until ${dateFormat.format(to)}';
    }

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(
              'Visitor Security Management System',
              style: pw.TextStyle(
                fontSize: 16,
                fontWeight: pw.FontWeight.bold,
                color: PdfColors.indigo800,
              ),
            ),
            pw.Text(
              'Generated: ${dateFormat.format(now)}',
              style: const pw.TextStyle(
                fontSize: 9,
                color: PdfColors.grey600,
              ),
            ),
          ],
        ),
        pw.SizedBox(height: 4),
        pw.Text(
          'Visitor Report  •  $range',
          style: const pw.TextStyle(fontSize: 11, color: PdfColors.grey700),
        ),
        pw.Divider(color: PdfColors.indigo200, thickness: 1.5),
        pw.SizedBox(height: 8),
      ],
    );
  }

  pw.Widget _buildFooter(pw.Context ctx, DateTime now) {
    return pw.Column(
      children: [
        pw.Divider(color: PdfColors.grey300),
        pw.SizedBox(height: 4),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(
              'Visitor Security Management System – Confidential',
              style: const pw.TextStyle(
                  fontSize: 8, color: PdfColors.grey500),
            ),
            pw.Text(
              'Page ${ctx.pageNumber} of ${ctx.pagesCount}',
              style: const pw.TextStyle(
                  fontSize: 8, color: PdfColors.grey500),
            ),
          ],
        ),
      ],
    );
  }

  pw.Widget _buildSummaryBox({
    required int total,
    required int approved,
    required int pending,
    required int rejected,
    required int checkedIn,
    required int checkedOut,
  }) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(12),
      decoration: pw.BoxDecoration(
        color: PdfColors.indigo50,
        borderRadius: pw.BorderRadius.circular(6),
        border: pw.Border.all(color: PdfColors.indigo200),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
        children: [
          _statCell('Total', total, PdfColors.indigo700),
          _statCell('Approved', approved, PdfColors.green700),
          _statCell('Pending', pending, PdfColors.orange700),
          _statCell('Rejected', rejected, PdfColors.red700),
          _statCell('Checked In', checkedIn, PdfColors.teal700),
          _statCell('Checked Out', checkedOut, PdfColors.blueGrey600),
        ],
      ),
    );
  }

  pw.Widget _statCell(String label, int value, PdfColor color) {
    return pw.Column(
      children: [
        pw.Text(
          '$value',
          style: pw.TextStyle(
            fontSize: 20,
            fontWeight: pw.FontWeight.bold,
            color: color,
          ),
        ),
        pw.SizedBox(height: 2),
        pw.Text(
          label,
          style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey600),
        ),
      ],
    );
  }

  pw.Widget _buildVisitorTable(
    List<VisitorModel> visitors,
    DateFormat dateFormat,
    DateFormat timeFormat,
  ) {
    const cellStyle = pw.TextStyle(fontSize: 8);

    final headers = [
      '#',
      'Name',
      'Phone',
      'Apartment',
      'Host',
      'Visit Date',
      'Check-In',
      'Check-Out',
      'Status',
    ];

    final rows = visitors.asMap().entries.map((entry) {
      final i = entry.key;
      final v = entry.value;
      return [
        '${i + 1}',
        v.name,
        v.phone,
        v.apartmentNo,
        v.hostName,
        dateFormat.format(v.visitDate),
        timeFormat.format(v.checkInTime),
        v.checkOutTime != null ? timeFormat.format(v.checkOutTime!) : '–',
        v.status.name.toUpperCase(),
      ];
    }).toList();

    return pw.TableHelper.fromTextArray(
      headers: headers,
      data: rows,
      border: pw.TableBorder.all(color: PdfColors.grey300, width: 0.5),
      headerStyle: pw.TextStyle(
        fontWeight: pw.FontWeight.bold,
        fontSize: 9,
        color: PdfColors.white,
      ),
      headerDecoration: const pw.BoxDecoration(color: PdfColors.indigo700),
      cellStyle: cellStyle,
      cellAlignments: {
        0: pw.Alignment.center,
        8: pw.Alignment.center,
      },
      oddRowDecoration: const pw.BoxDecoration(color: PdfColors.indigo50),
      columnWidths: {
        0: const pw.FixedColumnWidth(20),
        1: const pw.FlexColumnWidth(2.5),
        2: const pw.FlexColumnWidth(2),
        3: const pw.FlexColumnWidth(1.5),
        4: const pw.FlexColumnWidth(2),
        5: const pw.FlexColumnWidth(2),
        6: const pw.FlexColumnWidth(1.5),
        7: const pw.FlexColumnWidth(1.5),
        8: const pw.FlexColumnWidth(1.5),
      },
    );
  }
}
