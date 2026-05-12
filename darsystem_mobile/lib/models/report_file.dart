/// Represents a single activity entry within a Daily Activity Report.
/// Each row contains information about a specific activity performed during a time period.
class ReportRow {
  /// The start date and time of the activity (format: typically DD/MM/YYYY HH:MM)
  final String startDate;

  /// The end date and time of the activity (format: typically DD/MM/YYYY HH:MM)
  final String endDate;

  /// Brief description of the activity performed
  final String activity;

  /// Detailed description of what was accomplished during this activity
  final String details;

  /// Additional notes, observations, or remarks about the activity
  final String remarks;

  /// Creates a new ReportRow with the specified activity information.
  ///
  /// All parameters are required to ensure complete activity documentation.
  ReportRow({
    required this.startDate,
    required this.endDate,
    required this.activity,
    required this.details,
    required this.remarks,
  });

  /// Converts the ReportRow to a JSON-compatible map for storage or transmission.
  ///
  /// Returns a Map with keys: 'startDate', 'endDate', 'activity', 'details', 'remarks'
  Map<String, dynamic> toJson() => {
    'startDate': startDate,
    'endDate': endDate,
    'activity': activity,
    'details': details,
    'remarks': remarks,
  };

  /// Creates a ReportRow instance from a JSON map.
  ///
  /// Provides default empty strings for missing fields to ensure data integrity.
  /// Used when loading reports from storage or receiving data from external sources.
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

/// Represents a complete Daily Activity Report file.
/// Contains metadata about the report and a collection of activity rows.
class ReportFile {
  /// The display name/title of the report
  final String name;

  /// File system path where the report PDF is stored
  final String path;

  /// Current status of the report (e.g., 'Draft', 'Submitted', 'Approved')
  final String status;

  /// Timestamp when the report was created
  final DateTime createdAt;

  /// List of activity entries that make up the report content
  final List<ReportRow> rows;

  /// Creates a new ReportFile with the specified metadata and content.
  ///
  /// All parameters are required to ensure the report has complete information.
  ReportFile({
    required this.name,
    required this.path,
    required this.status,
    required this.createdAt,
    required this.rows,
  });

  /// Converts the ReportFile to a JSON-compatible map for storage or transmission.
  ///
  /// Includes all metadata and recursively converts all ReportRow objects to JSON.
  /// The 'createdAt' DateTime is converted to ISO 8601 string format.
  Map<String, dynamic> toJson() => {
    'name': name,
    'path': path,
    'status': status,
    'createdAt': createdAt.toIso8601String(),
    'rows': rows.map((e) => e.toJson()).toList(),
  };

  /// Creates a ReportFile instance from a JSON map.
  ///
  /// Handles parsing of the 'createdAt' timestamp from ISO 8601 string format.
  /// Provides default status and empty rows list if data is missing.
  /// Used when loading reports from persistent storage.
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
