class ReportRow {
  final String startDate;
  final String endDate;
  final String activity;
  final String details;
  final String remarks;

  ReportRow({
    required this.startDate,
    required this.endDate,
    required this.activity,
    required this.details,
    required this.remarks,
  });

  Map<String, dynamic> toJson() => {
        'startDate': startDate,
        'endDate': endDate,
        'activity': activity,
        'details': details,
        'remarks': remarks,
      };

  factory ReportRow.fromJson(Map<String, dynamic> json) {
    return ReportRow(
      startDate: json['startDate'] ?? '',
      endDate: json['endDate'] ?? '',
      activity: json['activity'] ?? '',
      details: json['details'] ?? '',
      remarks: json['remarks'] ?? '',
    );
  }
}



class ReportFile {
  final String name;
  final String path;
  final String status;
  final DateTime createdAt;

  final List<ReportRow> rows; // 🔥 NEW

  ReportFile({
    required this.name,
    required this.path,
    required this.status,
    required this.createdAt,
    required this.rows,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'path': path,
        'status': status,
        'createdAt': createdAt.toIso8601String(),
        'rows': rows.map((e) => e.toJson()).toList(),
      };

  factory ReportFile.fromJson(Map<String, dynamic> json) {
    return ReportFile(
      name: json['name'],
      path: json['path'],
      status: json['status'] ?? 'Submitted',
      createdAt: DateTime.parse(json['createdAt']),
      rows: (json['rows'] as List? ?? [])
          .map((e) => ReportRow.fromJson(e))
          .toList(),
    );
  }
}
