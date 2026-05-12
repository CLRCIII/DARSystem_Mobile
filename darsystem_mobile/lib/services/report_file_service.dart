import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import '../models/report_file.dart';

/// Service class responsible for handling PDF file operations in the DAR System.
/// Provides functionality to export and open PDF reports with proper handling
/// of Android's scoped storage restrictions across different Android versions.
class ReportFileService {
  /// Exports a PDF report to external storage and attempts to open it.
  ///
  /// This method handles the complexities of Android's changing storage permissions:
  /// - Android 9 and below: Direct access to Downloads folder
  /// - Android 10+: Scoped storage requires fallback to app-private storage
  ///
  /// [report] The ReportFile containing the PDF data and metadata
  /// Returns a status message indicating success or failure of the operation
  static Future<String> exportAndOpenPdf(ReportFile report) async {
    try {
      // Verify the source PDF file exists
      final sourceFile = File(report.path);

      if (!await sourceFile.exists()) {
        return "Source file not found";
      }

      // Read the PDF content as bytes
      final bytes = await sourceFile.readAsBytes();

      // Ensure filename has .pdf extension
      final fileName = report.name.endsWith('.pdf')
          ? report.name
          : '${report.name}.pdf';

      File? savedFile;

      // 🟡 STRATEGY 1: Try direct Downloads folder (Android 9 and below / some devices)
      // This works on older Android versions or devices with permissive storage access
      try {
        final downloadDir = Directory('/storage/emulated/0/Download');

        if (await downloadDir.exists()) {
          final directFile = File('${downloadDir.path}/$fileName');
          await directFile.writeAsBytes(bytes);
          savedFile = directFile;
        }
      } catch (e) {
        // Silently ignore and proceed to fallback strategy
        // This is expected on Android 10+ with scoped storage
      }

      // 🟢 STRATEGY 2: Fallback to app-safe storage (Android 10–15)
      // Uses getApplicationDocumentsDirectory() which is always accessible
      if (savedFile == null) {
        final appDir = await getApplicationDocumentsDirectory();
        savedFile = File('${appDir.path}/$fileName');
        await savedFile.writeAsBytes(bytes);
      }

      // 🟢 STRATEGY 3: Attempt to open the saved file
      // Uses the open_file package to launch the system's PDF viewer
      final result = await OpenFile.open(savedFile.path);

      if (result.type != ResultType.done) {
        return "Saved but cannot open file: ${result.message}";
      }

      // 🟡 Provide user feedback based on where the file was saved
      // This helps users understand Android's storage restrictions
      if (savedFile.path.contains("/Download")) {
        return "Downloaded to Downloads folder";
      } else {
        return "Saved in app storage (Downloads blocked by Android)";
      }
    } catch (e) {
      // Catch any unexpected errors during the export process
      return "Export failed: $e";
    }
  }
}
