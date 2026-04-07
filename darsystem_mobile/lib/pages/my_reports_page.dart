import 'package:flutter/material.dart';
import '../widgets/logo_container.dart';
import 'home_page.dart';
import 'dashboard_page.dart';
import 'profile_page.dart';
import 'report_details_page.dart';
import 'create_report_page.dart';

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

class _ReportsListSection extends StatelessWidget {
  const _ReportsListSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(22),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Submitted Reports',
            style: TextStyle(
              color: Color(0xFF111827),
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 16),
          _MyReportCard(
            title: 'Daily Accomplishment Report',
            fileName: 'DAR_March_25.pdf',
            submittedDate: 'March 25, 2026',
            status: 'Approved',
          ),
          _MyReportCard(
            title: 'Weekly Accomplishment Report',
            fileName: 'Weekly_Report_Maria.pdf',
            submittedDate: 'March 26, 2026',
            status: 'Pending',
          ),
          _MyReportCard(
            title: 'Monthly Summary Report',
            fileName: 'Monthly_Summary_March.pdf',
            submittedDate: 'March 30, 2026',
            status: 'For Revision',
          ),
          _MyReportCard(
            title: 'Daily Accomplishment Report',
            fileName: 'DAR_April_01.pdf',
            submittedDate: 'April 1, 2026',
            status: 'Submitted',
          ),
        ],
      ),
    );
  }
}

class _MyReportCard extends StatelessWidget {
  final String title;
  final String fileName;
  final String submittedDate;
  final String status;

  const _MyReportCard({
    required this.title,
    required this.fileName,
    required this.submittedDate,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final statusStyle = _getStatusStyle(status);

    return Container(
      width: double.infinity,
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
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF111827),
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          _infoRow('File Name', fileName),
          const SizedBox(height: 6),
          _infoRow('Submitted', submittedDate),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: statusStyle.background,
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              status,
              style: TextStyle(
                color: statusStyle.foreground,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _actionButton(
                'View',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ReportDetailsPage(),
                    ),
                  );
                },
              ),
              _actionButton('Download', onTap: () {}),
              _actionButton('Edit', onTap: status == 'Approved' ? null : () {}),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Row(
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: const TextStyle(
              color: Color(0xFF6B7280),
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(color: Color(0xFF374151), fontSize: 13),
          ),
        ),
      ],
    );
  }

  Widget _actionButton(String label, {VoidCallback? onTap}) {
    final disabled = onTap == null;

    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: disabled
            ? const Color(0xFFE5E7EB)
            : const Color(0xFF0A3F72),
        foregroundColor: disabled ? const Color(0xFF9CA3AF) : Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
      case 'For Revision':
        return const _StatusStyle(
          background: Color(0xFFFEE2E2),
          foreground: Color(0xFF991B1B),
        );
      default:
        return const _StatusStyle(
          background: Color(0xFFEDE9FE),
          foreground: Color(0xFF6D28D9),
        );
    }
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

class _StatusStyle {
  final Color background;
  final Color foreground;

  const _StatusStyle({required this.background, required this.foreground});
}
