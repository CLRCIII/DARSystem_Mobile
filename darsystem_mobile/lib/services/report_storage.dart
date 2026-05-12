import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/report_file.dart';

/// Service class for managing persistent storage of Daily Activity Reports.
/// Uses SharedPreferences to store report data locally on the device.
/// Provides methods to save, retrieve, and manage collections of reports.
class ReportStorage {
  /// Storage key used to identify the reports collection in SharedPreferences
  static const String key = 'reports';

  /// Retrieves all saved reports from persistent storage.
  ///
  /// Returns a List of ReportFile objects deserialized from JSON storage.
  /// If no reports are stored, returns an empty list.
  /// Reports are stored as JSON strings and converted back to ReportFile objects.
  static Future<List<ReportFile>> getReports() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList(key) ?? [];

    return data.map((e) => ReportFile.fromJson(jsonDecode(e))).toList();
  }

  /// Saves a single report to persistent storage.
  ///
  /// Adds the new report to the existing collection of reports.
  /// [report] The ReportFile to be saved
  /// Note: This appends to existing reports; use overwriteReports() to replace all reports.
  static Future<void> saveReport(ReportFile report) async {
    final prefs = await SharedPreferences.getInstance();
    final reports = await getReports();

    reports.add(report);

    final data = reports.map((e) => jsonEncode(e.toJson())).toList();

    await prefs.setStringList(key, data);
  }

  /// Replaces all existing reports with a new collection.
  ///
  /// Completely overwrites the stored reports with the provided list.
  /// Useful for bulk operations like importing reports or clearing old data.
  /// [reports] The complete list of ReportFile objects to store
  static Future<void> overwriteReports(List<ReportFile> reports) async {
    final prefs = await SharedPreferences.getInstance();

    final data = reports.map((e) => jsonEncode(e.toJson())).toList();

    await prefs.setStringList(key, data);
  }
}
