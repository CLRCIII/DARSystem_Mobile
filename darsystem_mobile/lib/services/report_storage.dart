import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/report_file.dart';

class ReportStorage {
  static const String key = 'reports';

  // ✅ EXISTING: Get reports
  static Future<List<ReportFile>> getReports() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList(key) ?? [];

    return data.map((e) => ReportFile.fromJson(jsonDecode(e))).toList();
  }

  // ✅ EXISTING (optional): Save one report
  static Future<void> saveReport(ReportFile report) async {
    final prefs = await SharedPreferences.getInstance();
    final reports = await getReports();

    reports.add(report);

    final data = reports.map((e) => jsonEncode(e.toJson())).toList();

    await prefs.setStringList(key, data);
  }

  // 🔥 ADD THIS HERE
  static Future<void> overwriteReports(List<ReportFile> reports) async {
    final prefs = await SharedPreferences.getInstance();

    final data = reports.map((e) => jsonEncode(e.toJson())).toList();

    await prefs.setStringList(key, data);
  }
}
