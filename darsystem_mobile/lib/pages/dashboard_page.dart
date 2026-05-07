import 'package:darsystem_mobile/services/report_file_service.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';

import '../widgets/logo_container.dart';
import '../services/report_storage.dart';
import '../models/report_file.dart';

import 'home_page.dart';
import 'profile_page.dart';
import 'notifications_page.dart';
import 'create_new_report_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  Future<List<ReportFile>> _reportsFuture = ReportStorage.getReports();

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  void _refresh() {
    setState(() {
      _reportsFuture = ReportStorage.getReports();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDCDCDC),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF0C4C7F),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateNewReportPage(),
            ),
          );
          _refresh();
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const _DashboardTopBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildQuickActionBar(context),
                    const SizedBox(height: 20),
                    _buildSummaryCards(),
                    const SizedBox(height: 20),
                    _buildReportsSection(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome back',
                  style: TextStyle(color: Color(0xFF6B7280), fontSize: 13),
                ),
                SizedBox(height: 4),
                Text(
                  'Manage and track your reports here.',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          ElevatedButton.icon(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CreateNewReportPage(),
                ),
              );
              _refresh();
            },
            icon: const Icon(Icons.add),
            label: const Text('Create'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0A3F72),
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCards() {
    return FutureBuilder<List<ReportFile>>(
      future: _reportsFuture,
      builder: (context, snapshot) {
        final reports = snapshot.data ?? [];

        int submitted = reports.length;
        int approved = reports.where((r) => r.status == 'Approved').length;
        int pending = reports.where((r) => r.status == 'Pending').length;
        int revision = reports.where((r) => r.status == 'Revision').length;

        return GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 1.35,
          children: [
            _SummaryCard(
              title: 'Submitted',
              count: submitted,
              color: const Color(0xFFEFF6FF),
              iconColor: const Color(0xFF2563EB),
              icon: Icons.insert_drive_file,
            ),
            _SummaryCard(
              title: 'Approved',
              count: approved,
              color: const Color(0xFFECFDF5),
              iconColor: const Color(0xFF16A34A),
              icon: Icons.check_circle,
            ),
            _SummaryCard(
              title: 'Pending',
              count: pending,
              color: const Color(0xFFFFFBEB),
              iconColor: const Color(0xFFD97706),
              icon: Icons.schedule,
            ),
            _SummaryCard(
              title: 'Revision',
              count: revision,
              color: const Color(0xFFFEF2F2),
              iconColor: const Color(0xFFDC2626),
              icon: Icons.edit,
            ),
          ],
        );
      },
    );
  }

  Widget _buildReportsSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'My Reports',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 14),
          FutureBuilder<List<ReportFile>>(
            future: _reportsFuture,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final reports = snapshot.data!;

              if (reports.isEmpty) {
                return const Text('No reports yet.');
              }

              return Column(
                children: reports.map((report) {
                  final style = _getStatusStyle(report.status);

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: const Color(0xFFE5E7EB)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                report.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),

                            if (report.status.toLowerCase() == 'draft') ...[
                              IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  size: 18,
                                  color: Color(0xFF0A3F72),
                                ),
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => CreateNewReportPage(
                                        existingReport: report,
                                      ),
                                    ),
                                  );
                                },
                              ),

                              IconButton(
                                icon: const Icon(
                                  Icons.download,
                                  size: 18,
                                  color: Color(0xFF2563EB),
                                ),
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                onPressed: () async {
                                  final result =
                                      await ReportFileService.exportAndOpenPdf(
                                        report,
                                      );

                                  if (!context.mounted) return;

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(result)),
                                  );
                                },
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          report.createdAt.toString(),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: style.background,
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            report.status,
                            style: TextStyle(
                              color: style.foreground,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),

                        Wrap(
                          spacing: 8,
                          children: [
                            _actionButton('Open', () {
                              OpenFile.open(report.path);
                            }, const Color(0xFF0A3F72)),
                            _actionButton('Submit', () {
                              OpenFile.open(report.path);
                            }, const Color.fromARGB(255, 50, 235, 37)),
                            _actionButton('Delete', () async {
                              final updated = reports
                                  .where((r) => r.path != report.path)
                                  .toList();
                              await ReportStorage.overwriteReports(updated);
                              _refresh();
                            }, const Color(0xFFDC2626)),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _actionButton(String label, VoidCallback onTap, Color color) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      child: Text(label),
    );
  }

  _StatusStyle _getStatusStyle(String status) {
    switch (status) {
      case 'Approved':
        return const _StatusStyle(
          background: Color(0xFFDCFCE7),
          foreground: Color(0xFF166534),
        );
      case 'Pending':
        return const _StatusStyle(
          background: Color(0xFFFEF3C7),
          foreground: Color(0xFF92400E),
        );
      case 'Revision':
        return const _StatusStyle(
          background: Color(0xFFFEE2E2),
          foreground: Color(0xFF991B1B),
        );
      default:
        return const _StatusStyle(
          background: Color(0xFFDBEAFE),
          foreground: Color(0xFF1E3A8A),
        );
    }
  }
}

/* ================= UI COMPONENTS ================= */

class _DashboardTopBar extends StatelessWidget {
  const _DashboardTopBar();

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
          _NavButton('Home', () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HomePage()),
            );
          }),
          const _NavButton('Dashboard', null, true),
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const NotificationsPage()),
              );
            },
          ),
          _NavButton('Profile', () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const ProfilePage()),
            );
          }),
        ],
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final bool isActive;

  const _NavButton(this.label, this.onTap, [this.isActive = false]);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isActive ? null : onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Text(
          label,
          style: TextStyle(color: isActive ? Colors.white : Colors.white70),
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final int count;
  final Color color;
  final Color iconColor;
  final IconData icon;

  const _SummaryCard({
    required this.title,
    required this.count,
    required this.color,
    required this.iconColor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          const SizedBox(height: 10),
          Row(
            children: [
              Text(
                '$count',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Icon(icon, color: iconColor),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatusStyle {
  final Color background;
  final Color foreground;

  const _StatusStyle({required this.background, required this.foreground});
}
