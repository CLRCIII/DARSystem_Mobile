import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import '../models/report_file.dart';

class ReportFileService {
  static Future<String> exportAndOpenPdf(ReportFile report) async {
    try {
      final sourceFile = File(report.path);

      if (!await sourceFile.exists()) {
        return "Source file not found";
      }

      final bytes = await sourceFile.readAsBytes();

      final fileName = report.name.endsWith('.pdf')
          ? report.name
          : '${report.name}.pdf';

      File? savedFile;

      // 🟡 1. TRY direct Downloads folder (Android 9 and below / some devices)
      try {
        final downloadDir = Directory('/storage/emulated/0/Download');

        if (await downloadDir.exists()) {
          final directFile = File('${downloadDir.path}/$fileName');
          await directFile.writeAsBytes(bytes);
          savedFile = directFile;
        }
      } catch (e) {
        // ignore and fallback
      }

      // 🟢 2. FALLBACK: app-safe storage (Android 10–15)
      if (savedFile == null) {
        final appDir = await getApplicationDocumentsDirectory();
        savedFile = File('${appDir.path}/$fileName');
        await savedFile.writeAsBytes(bytes);
      }

      // 🟢 3. OPEN FILE
      final result = await OpenFile.open(savedFile.path);

      if (result.type != ResultType.done) {
        return "Saved but cannot open file: ${result.message}";
      }

      // 🟡 Message depends on where it landed
      if (savedFile.path.contains("/Download")) {
        return "Downloaded to Downloads folder";
      } else {
        return "Saved in app storage (Downloads blocked by Android)";
      }
    } catch (e) {
      return "Export failed: $e";
    }
  }
}
