import 'package:flutter/material.dart';
import '../widgets/logo_container.dart';
import 'home_page.dart';
import 'dashboard_page.dart';
import 'profile_page.dart';
import 'report_details_page.dart';
import 'create_report_page.dart';
import '../models/report_file.dart';
import '../services/report_storage.dart';

class MyReportsPage extends StatelessWidget {
  const MyReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDCDCDC),
      body: SafeArea(
        child: Column(
          children: [
            const _MyReportsTopBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    _MyReportsHeaderCard(),
                    SizedBox(height: 18),
                    _CreateReportActionCard(),
                    SizedBox(height: 18),
                    _ReportsSummarySection(),
                    SizedBox(height: 18),
                    _ReportsListSection(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MyReportsTopBar extends StatelessWidget {
  const _MyReportsTopBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0A3F72), Color(0xFF0C4F88)],
        ),
      ),
      child: Row(
        children: [
          const Row(
            children: [
              LogoContainer(imagePath: 'assets/images/dict_logo.png', size: 30),
              SizedBox(width: 8),
              LogoContainer(
                imagePath: 'assets/images/bagong_pilipinas.png',
                size: 30,
              ),
            ],
          ),
          const Spacer(),
          _NavButton(
            label: 'Home',
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            },
          ),
          const SizedBox(width: 8),
          _NavButton(
            label: 'Dashboard',
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const DashboardPage()),
              );
            },
          ),
          const SizedBox(width: 8),
          _NavButton(
            label: 'Profile',
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              );
            },
          ),
          const SizedBox(width: 8),
          const _NavButton(label: 'Reports', isActive: true),
        ],
      ),
    );
  }
}

class _MyReportsHeaderCard extends StatelessWidget {
  const _MyReportsHeaderCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(22),
      ),
      child: const Column(
        children: [
          CircleAvatar(
            radius: 42,
            backgroundColor: Color(0xFF0C4C7F),
            child: Icon(
              Icons.description_outlined,
              color: Colors.white,
              size: 34,
            ),
          ),
          SizedBox(height: 14),
          Text(
            'My Reports',
            style: TextStyle(
              color: Color(0xFF111827),
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'View your submitted accomplishment reports and their current status.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Color(0xFF6B7280), fontSize: 13.5),
          ),
        ],
      ),
    );
  }
}

class _CreateReportActionCard extends StatelessWidget {
  const _CreateReportActionCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFEEF6FF),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFD5E6FB)),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: const Color(0xFF0C4C7F),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.note_add_outlined, color: Colors.white),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Create a new report',
                  style: TextStyle(
                    color: Color(0xFF111827),
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'The mobile version now includes the create report feature from the DAR web system.',
                  style: TextStyle(
                    color: Color(0xFF4B5563),
                    fontSize: 12.8,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CreateReportPage(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0A3F72),
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }
}

class _ReportsSummarySection extends StatelessWidget {
  const _ReportsSummarySection();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: _MiniSummaryCard(
            title: 'Submitted',
            value: '24',
            background: Color(0xFFEDE9FE),
            foreground: Color(0xFF6D28D9),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: _MiniSummaryCard(
            title: 'Approved',
            value: '18',
            background: Color(0xFFDCFCE7),
            foreground: Color(0xFF166534),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: _MiniSummaryCard(
            title: 'Pending',
            value: '4',
            background: Color(0xFFFEF3C7),
            foreground: Color(0xFF92400E),
          ),
        ),
      ],
    );
  }
}

class _ReportsListSection extends StatefulWidget {
  const _ReportsListSection();

  @override
  State<_ReportsListSection> createState() => _ReportsListSectionState();
}

class _ReportsListSectionState extends State<_ReportsListSection> {
  final TextEditingController _searchController = TextEditingController();

  String _selectedStatus = 'All';
  late Future<List<ReportFile>> _futureReports;

  @override
  void initState() {
    super.initState();
    _futureReports = ReportStorage.getReports();
  }

  void _refresh() {
    setState(() {
      _futureReports = ReportStorage.getReports();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ReportFile>>(
      future: _futureReports,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(child: Text("Error loading reports"));
        }

        final reports = snapshot.data ?? [];

        final filteredReports = reports.where((r) {
          final query = _searchController.text.toLowerCase();

          final matchesSearch =
              query.isEmpty || r.name.toLowerCase().contains(query);

          final matchesStatus =
              _selectedStatus == 'All' || r.status == _selectedStatus;

          return matchesSearch && matchesStatus;
        }).toList();

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: const Color(0xFFF7F7F7),
            borderRadius: BorderRadius.circular(22),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Reports',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),

              const SizedBox(height: 12),

              TextField(
                controller: _searchController,
                onChanged: (_) => setState(() {}),
                decoration: const InputDecoration(
                  hintText: "Search reports...",
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                ),
              ),

              const SizedBox(height: 12),

              Wrap(
                spacing: 8,
                children: [
                  _chip("All"),
                  _chip("Draft"),
                  _chip("Submitted"),
                  _chip("Approved"),
                  _chip("Pending"),
                ],
              ),

              const SizedBox(height: 16),

              if (filteredReports.isEmpty)
                const Text("No reports found.")
              else
                ...filteredReports.map((report) {
                  return _MyReportCard(
                    title: report.name,
                    fileName: report.name,
                    submittedDate: report.createdAt.toString(),
                    status: report.status,

                    onRename: () {},

                    onDelete: () async {
                      final list = await ReportStorage.getReports();
                      list.removeWhere((r) => r.name == report.name);
                      await ReportStorage.overwriteReports(list);
                      _refresh();
                    },

                    onTapEdit: report.status == "Draft"
                        ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const CreateReportPage(),
                              ),
                            );
                          }
                        : null,
                  );
                }),
            ],
          ),
        );
      },
    );
  }

  Widget _chip(String label) {
    final selected = _selectedStatus == label;

    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) {
        setState(() => _selectedStatus = label);
      },
    );
  }
}

class _MyReportCard extends StatelessWidget {
  final String title;
  final String fileName;
  final String submittedDate;
  final String status;

  final VoidCallback? onRename;
  final VoidCallback? onDelete;
  final VoidCallback? onTapEdit;

  const _MyReportCard({
    required this.title,
    required this.fileName,
    required this.submittedDate,
    required this.status,
    this.onRename,
    this.onDelete,
    this.onTapEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),

          const SizedBox(height: 10),

          Text("File: $fileName"),
          Text("Date: $submittedDate"),
          Text("Status: $status"),

          const SizedBox(height: 12),

          Wrap(
            spacing: 8,
            children: [
              ElevatedButton(onPressed: onTapEdit, child: const Text("Edit")),
              ElevatedButton(onPressed: onDelete, child: const Text("Delete")),
            ],
          ),
        ],
      ),
    );
  }
}

class _MiniSummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final Color background;
  final Color foreground;

  const _MiniSummaryCard({
    required this.title,
    required this.value,
    required this.background,
    required this.foreground,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              color: foreground,
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF4B5563),
              fontSize: 12.5,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback? onTap;

  const _NavButton({required this.label, this.isActive = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isActive ? null : onTap,
      borderRadius: BorderRadius.circular(999),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.white70,
            fontSize: 13,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

class _ReportItem {
  final String title;
  final String fileName;
  final String submittedDate;
  final String status;

  const _ReportItem({
    required this.title,
    required this.fileName,
    required this.submittedDate,
    required this.status,
  });

  _ReportItem copyWith({
    String? title,
    String? fileName,
    String? submittedDate,
    String? status,
  }) {
    return _ReportItem(
      title: title ?? this.title,
      fileName: fileName ?? this.fileName,
      submittedDate: submittedDate ?? this.submittedDate,
      status: status ?? this.status,
    );
  }
}

class _StatusStyle {
  final Color background;
  final Color foreground;

  const _StatusStyle({required this.background, required this.foreground});
}
