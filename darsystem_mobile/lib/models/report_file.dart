class ReportFile {
  final String name;
  final String path;
  final String status;
  final DateTime createdAt;

  ReportFile({
    required this.name,
    required this.path,
    required this.status, // ✅ FIXED
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'path': path,
    'status': status, // ✅ FIXED
    'createdAt': createdAt.toIso8601String(),
  };

  factory ReportFile.fromJson(Map<String, dynamic> json) {
    return ReportFile(
      name: json['name'],
      path: json['path'],
      status: json['status'] ?? 'Submitted', // ✅ fallback (VERY IMPORTANT)
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
