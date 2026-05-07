import 'dart:io';
import 'dart:typed_data';

import 'package:darsystem_mobile/services/report_file_service.dart';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

import '../widgets/logo_container.dart';
import '../services/report_storage.dart';
import '../models/report_file.dart';
import 'dashboard_page.dart';
import 'package:path_provider/path_provider.dart';

class CreateNewReportPage extends StatefulWidget {
  final ReportFile? existingReport; // 🔥 ADD THIS

  const CreateNewReportPage({super.key, this.existingReport});

  @override
  State<CreateNewReportPage> createState() => _CreateNewReportPageState();
}

class _CreateNewReportPageState extends State<CreateNewReportPage> {
  @override
  @override
  void initState() {
    super.initState();

    final report = widget.existingReport;
    if (report == null) return;

    _generatedFileNameController.text = report.name;

    _rows.clear();

    if (report.rows.isNotEmpty) {
      for (final r in report.rows) {
        _rows.add(
          ReportRowData()
            ..startDateController.text = r.startDate
            ..endDateController.text = r.endDate
            ..activityController.text = r.activity
            ..detailsController.text = r.details
            ..remarksController.text = r.remarks,
        );
      }
    } else {
      // fallback so UI doesn’t break
      _rows.add(ReportRowData());
    }
  }

  final TextEditingController _generatedFileNameController =
      TextEditingController(text: 'ACCOMPLISHMENT_REPORT.pdf');

  final List<ReportRowData> _rows = [ReportRowData()];

  @override
  void dispose() {
    _generatedFileNameController.dispose();
    for (final row in _rows) {
      row.dispose();
    }
    super.dispose();
  }

  void _addRow() {
    setState(() {
      _rows.add(ReportRowData());
    });
  }

  void _deleteRow(int index) {
    if (_rows.length == 1) return;
    setState(() {
      _rows[index].dispose();
      _rows.removeAt(index);
    });
  }

  Future<void> _pickDate(
    BuildContext context,
    TextEditingController controller,
  ) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2035),
    );

    if (picked != null) {
      final m = picked.month.toString().padLeft(2, '0');
      final d = picked.day.toString().padLeft(2, '0');
      controller.text = '$m/$d/${picked.year}';
    }
  }

  Future<Uint8List> _generatePdfBytes() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        margin: const pw.EdgeInsets.all(24),
        build: (context) => [
          pw.Text(
            'ACCOMPLISHMENT REPORT',
            style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 20),
          pw.Table(
            border: pw.TableBorder.all(),
            columnWidths: {
              0: const pw.FlexColumnWidth(2),
              1: const pw.FlexColumnWidth(2),
              2: const pw.FlexColumnWidth(5),
              3: const pw.FlexColumnWidth(2),
            },
            children: [
              pw.TableRow(
                decoration: const pw.BoxDecoration(color: PdfColors.grey300),
                children: [
                  _pdfCell('Date Range', bold: true),
                  _pdfCell('Activity', bold: true),
                  _pdfCell('Details', bold: true),
                  _pdfCell('Remarks', bold: true),
                ],
              ),
              ..._rows.map((row) {
                return pw.TableRow(
                  children: [
                    _pdfCell(
                      '${row.startDateController.text}\n${row.endDateController.text}',
                    ),
                    _pdfCell(row.activityController.text),
                    _pdfCell(row.detailsController.text),
                    _pdfCell(row.remarksController.text),
                  ],
                );
              }).toList(),
            ],
          ),
        ],
      ),
    );

    return pdf.save();
  }

  pw.Widget _pdfCell(String text, {bool bold = false}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(6),
      child: pw.Text(
        text.isEmpty ? '-' : text,
        style: pw.TextStyle(
          fontSize: 10,
          fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal,
        ),
      ),
    );
  }

  Future<void> _previewPdf() async {
    final bytes = await _generatePdfBytes();
    await Printing.layoutPdf(onLayout: (format) async => bytes);
  }

//     Future<void> _downloadPdf() async {
//     final bytes = await _generatePdfBytes();

//     final fileName = _generatedFileNameController.text.isNotEmpty
//         ? _generatedFileNameController.text
//         : 'report.pdf';

//     await ReportFileService.exportAndOpenPdf(
//   bytes: bytes,
//   fileName: fileName,
// );

//   if (!mounted) return;

//   ScaffoldMessenger.of(context).showSnackBar(
//     const SnackBar(content: Text('Report downloaded & opened')),
//   );
// }

  Future<void> _saveDraft() async {
  final bytes = await _generatePdfBytes();

  final fileName = _generatedFileNameController.text.isNotEmpty
      ? _generatedFileNameController.text
      : 'draft_report.pdf';

  late File file;

  // 🔥 EDIT MODE
  if (widget.existingReport != null) {
    file = File(widget.existingReport!.path);
  }
  // 🆕 CREATE MODE
  else {
    final directory = await getApplicationDocumentsDirectory();
    file = File('${directory.path}/$fileName');
  }

  await file.writeAsBytes(bytes);

  final report = ReportFile(
    name: fileName,
    path: file.path,
    status: 'Draft',
    createdAt: DateTime.now(),
    rows: _rows.map((row) {
      return ReportRow(
        startDate: row.startDateController.text,
        endDate: row.endDateController.text,
        activity: row.activityController.text,
        details: row.detailsController.text,
        remarks: row.remarksController.text,
      );
    }).toList(),
  );

  if (widget.existingReport != null) {
    final list = await ReportStorage.getReports();

    final updatedList = list.map((r) {
      return r.path == widget.existingReport!.path ? report : r;
    }).toList();

    await ReportStorage.overwriteReports(updatedList);
  } else {
    await ReportStorage.saveReport(report);
  }

  if (!mounted) return;

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Draft saved successfully')),
  );
}

  Future<void> _submitReport() async {
    final bytes = await _generatePdfBytes();

    final fileName = _generatedFileNameController.text.isNotEmpty
        ? _generatedFileNameController.text
        : 'report.pdf';

    final directory = Directory('/storage/emulated/0/Download');

    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }

    final file = File(widget.existingReport!.path);
    await file.writeAsBytes(bytes);

    await ReportStorage.saveReport(
      ReportFile(
        name: fileName,
        path: file.path,
        status: 'Draft', // or Submitted
        createdAt: DateTime.now(),

        rows: _rows.map((row) {
          return ReportRow(
            startDate: row.startDateController.text,
            endDate: row.endDateController.text,
            activity: row.activityController.text,
            details: row.detailsController.text,
            remarks: row.remarksController.text,
          );
        }).toList(),
      ),
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Report submitted successfully')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDCDCDC),
      body: SafeArea(
        child: Column(
          children: [
            const _TopBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2F2F2),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    children: [
                      _buildHeader(),
                      const SizedBox(height: 20),

                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Generated File Name'),
                      ),
                      const SizedBox(height: 8),

                      TextField(
                        controller: _generatedFileNameController,
                        decoration: _input(),
                      ),

                      const SizedBox(height: 20),

                      ...List.generate(
                        _rows.length,
                        (i) => _buildRowCard(_rows[i], i),
                      ),

                      const SizedBox(height: 20),

                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: _previewPdf,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF0A3F72),
                                foregroundColor: Colors.white,
                              ),
                              child: const Text('Preview'),
                            ),
                          ),

                          const SizedBox(width: 10),

                          Expanded(
                            child: ElevatedButton(
                              onPressed: _saveDraft,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFF59E0B),
                                foregroundColor: Colors.white,
                              ),
                              child: const Text(
                                'Save Draft',
                                style: TextStyle(fontSize: 11),
                              ),
                            ),
                          ),

                          const SizedBox(width: 10),

                          Expanded(
                            child: ElevatedButton(
                              onPressed: _submitReport,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF16A34A),
                                foregroundColor: Colors.white,
                              ),
                              child: const Text('Submit'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: const [
        LogoContainer(imagePath: 'assets/images/dict_logo.png', size: 60),
        SizedBox(width: 10),
        Expanded(
          child: Text(
            'DEPARTMENT OF INFORMATION AND\nCOMMUNICATIONS TECHNOLOGY\nREGION I – ILOCOS',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        LogoContainer(
          imagePath: 'assets/images/bagong_pilipinas.png',
          size: 60,
        ),
      ],
    );
  }

  Widget _buildRowCard(ReportRowData row, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    'Entry ${index + 1}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              IconButton(
                onPressed: () => _deleteRow(index),
                icon: const Icon(Icons.delete, color: Colors.red),
              ),
            ],
          ),

          TextField(
            controller: row.startDateController,
            readOnly: true,
            onTap: () => _pickDate(context, row.startDateController),
            decoration: _input(hint: 'Start Date'),
          ),
          const SizedBox(height: 8),

          TextField(
            controller: row.endDateController,
            readOnly: true,
            onTap: () => _pickDate(context, row.endDateController),
            decoration: _input(hint: 'End Date'),
          ),
          const SizedBox(height: 8),

          TextField(
            controller: row.activityController,
            decoration: _input(hint: 'Activity'),
          ),
          const SizedBox(height: 8),

          TextField(
            controller: row.detailsController,
            maxLines: 3,
            decoration: _input(hint: 'Details'),
          ),
          const SizedBox(height: 8),

          TextField(
            controller: row.remarksController,
            maxLines: 2,
            decoration: _input(hint: 'Remarks'),
          ),

          const SizedBox(height: 10),

          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: _addRow,
              icon: const Icon(Icons.add),
              label: const Text('Add Row'),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _input({String? hint}) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: const Color(0xFFF3F4F6),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
    );
  }
}

class ReportRowData {
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final activityController = TextEditingController();
  final detailsController = TextEditingController();
  final remarksController = TextEditingController();

  void dispose() {
    startDateController.dispose();
    endDateController.dispose();
    activityController.dispose();
    detailsController.dispose();
    remarksController.dispose();
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0C4C7F),
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          const Text('Create Report', style: TextStyle(color: Colors.white)),
          const Spacer(),
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const DashboardPage()),
              );
            },
            child: const Text(
              'Dashboard',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
