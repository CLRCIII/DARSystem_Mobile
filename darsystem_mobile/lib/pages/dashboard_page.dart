import 'package:flutter/material.dart';
import '../widgets/logo_container.dart';
import 'home_page.dart';
import 'profile_page.dart';
import 'notifications_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDCDCDC),
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

  Widget _buildSummaryCards() {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 1.35,
      children: const [
        _SummaryCard(
          title: 'Submitted',
          count: 24,
          subtitle: 'Reports',
          meta: 'Latest upload today',
          color: Color(0xFFF3EEFF),
          iconColor: Color(0xFF8B5CF6),
          icon: Icons.insert_drive_file_outlined,
        ),
        _SummaryCard(
          title: 'Approved',
          count: 18,
          subtitle: 'Reports',
          meta: 'Reviewed this week',
          color: Color(0xFFECFDF3),
          iconColor: Color(0xFF22C55E),
          icon: Icons.check_circle_outline,
        ),
        _SummaryCard(
          title: 'Pending',
          count: 4,
          subtitle: 'Reports',
          meta: 'Waiting for review',
          color: Color(0xFFFFF7ED),
          iconColor: Color(0xFFF59E0B),
          icon: Icons.access_time,
        ),
        _SummaryCard(
          title: 'For Revision',
          count: 2,
          subtitle: 'Reports',
          meta: 'Needs correction',
          color: Color(0xFFFEF2F2),
          iconColor: Color(0xFFEF4444),
          icon: Icons.edit_note,
        ),
      ],
    );
  }

  Widget _buildReportsSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Reports',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color(0xFF111827),
            ),
          ),
          SizedBox(height: 14),
          _ReportCard(
            name: 'Juan Dela Cruz',
            file: 'DAR_March_25.pdf',
            date: '03/25/2026',
            status: 'Approved',
          ),
          _ReportCard(
            name: 'Maria Santos',
            file: 'Weekly_Report_Maria.pdf',
            date: '03/26/2026',
            status: 'Pending',
          ),
          _ReportCard(
            name: 'Carlo Reyes',
            file: 'DAR_Carlo.docx',
            date: '03/27/2026',
            status: 'For Revision',
          ),
          _ReportCard(
            name: 'Anne Villanueva',
            file: 'Accomplishment_Report.pdf',
            date: '03/28/2026',
            status: 'Submitted',
          ),
        ],
      ),
    );
  }
}

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
          const _NavButton(label: 'Dashboard', isActive: true),
          const SizedBox(width: 10),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationsPage(),
                ),
              );
            },
            icon: const Icon(Icons.notifications_none, color: Colors.white),
          ),
          _NavButton(
            label: 'Profile',
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              );
            },
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

class _SummaryCard extends StatelessWidget {
  final String title;
  final int count;
  final String subtitle;
  final String meta;
  final Color color;
  final Color iconColor;
  final IconData icon;

  const _SummaryCard({
    required this.title,
    required this.count,
    required this.subtitle,
    required this.meta,
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
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF6B7280),
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Text(
                '$count',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF111827),
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  subtitle,
                  style: const TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 13,
                  ),
                ),
              ),
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: iconColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: Colors.white, size: 20),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            meta,
            style: const TextStyle(color: Color(0xFF6B7280), fontSize: 11.5),
          ),
        ],
      ),
    );
  }
}

class _ReportCard extends StatelessWidget {
  final String name;
  final String file;
  final String date;
  final String status;

  const _ReportCard({
    required this.name,
    required this.file,
    required this.date,
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
            name,
            style: const TextStyle(
              color: Color(0xFF111827),
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          _infoRow('File Name', file),
          const SizedBox(height: 6),
          _infoRow('Date Submitted', date),
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
              _actionButton('Review', onTap: () {}),
              _actionButton(
                'Remind',
                onTap: status == 'Approved' ? null : () {},
              ),
              _actionButton(
                'Export',
                onTap: status == 'Approved' ? () {} : null,
              ),
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
          width: 120,
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

class _StatusStyle {
  final Color background;
  final Color foreground;

  const _StatusStyle({required this.background, required this.foreground});
}
