import 'package:flutter/material.dart';
import '../widgets/logo_container.dart';
import 'home_page.dart';
import 'dashboard_page.dart';
import 'profile_page.dart';

class ActivityLogsPage extends StatelessWidget {
  const ActivityLogsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDCDCDC),
      body: SafeArea(
        child: Column(
          children: [
            const _ActivityLogsTopBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    _ActivityHeaderCard(),
                    SizedBox(height: 18),
                    _ActivityStatsSection(),
                    SizedBox(height: 18),
                    _ActivityTimelineSection(),
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

class _ActivityLogsTopBar extends StatelessWidget {
  const _ActivityLogsTopBar();

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
          const _NavButton(label: 'Logs', isActive: true),
        ],
      ),
    );
  }
}

class _ActivityHeaderCard extends StatelessWidget {
  const _ActivityHeaderCard();

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
            child: Icon(Icons.history, color: Colors.white, size: 34),
          ),
          SizedBox(height: 14),
          Text(
            'Activity Logs',
            style: TextStyle(
              color: Color(0xFF111827),
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Track recent account activity, report actions, and system events.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Color(0xFF6B7280), fontSize: 13.5),
          ),
        ],
      ),
    );
  }
}

class _ActivityStatsSection extends StatelessWidget {
  const _ActivityStatsSection();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: _ActivityStatCard(
            label: 'Today',
            value: '5',
            background: Color(0xFFE0F2FE),
            foreground: Color(0xFF075985),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: _ActivityStatCard(
            label: 'This Week',
            value: '18',
            background: Color(0xFFECFDF3),
            foreground: Color(0xFF166534),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: _ActivityStatCard(
            label: 'This Month',
            value: '42',
            background: Color(0xFFF3EEFF),
            foreground: Color(0xFF6D28D9),
          ),
        ),
      ],
    );
  }
}

class _ActivityTimelineSection extends StatelessWidget {
  const _ActivityTimelineSection();

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
            'Recent Activity',
            style: TextStyle(
              color: Color(0xFF111827),
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 16),
          _ActivityLogItem(
            title: 'Report Approved',
            description: 'Your Daily Accomplishment Report was approved.',
            dateTime: 'April 6, 2026 • 9:12 AM',
            icon: Icons.check_circle_outline,
            iconColor: Color(0xFF16A34A),
            iconBackground: Color(0xFFDCFCE7),
          ),
          _ActivityLogItem(
            title: 'Report Submitted',
            description: 'You submitted Weekly_Report_Maria.pdf.',
            dateTime: 'April 5, 2026 • 3:40 PM',
            icon: Icons.upload_file_outlined,
            iconColor: Color(0xFF2563EB),
            iconBackground: Color(0xFFDBEAFE),
          ),
          _ActivityLogItem(
            title: 'Revision Requested',
            description: 'Monthly_Summary_March.pdf needs correction.',
            dateTime: 'April 4, 2026 • 11:05 AM',
            icon: Icons.edit_note,
            iconColor: Color(0xFFDC2626),
            iconBackground: Color(0xFFFEE2E2),
          ),
          _ActivityLogItem(
            title: 'Password Changed',
            description: 'Your account password was updated successfully.',
            dateTime: 'April 3, 2026 • 7:24 PM',
            icon: Icons.lock_outline,
            iconColor: Color(0xFF7C3AED),
            iconBackground: Color(0xFFEDE9FE),
          ),
          _ActivityLogItem(
            title: 'Logged In',
            description: 'You signed in to your DICT account.',
            dateTime: 'April 3, 2026 • 7:10 PM',
            icon: Icons.login,
            iconColor: Color(0xFF0F766E),
            iconBackground: Color(0xFFCCFBF1),
          ),
        ],
      ),
    );
  }
}

class _ActivityLogItem extends StatelessWidget {
  final String title;
  final String description;
  final String dateTime;
  final IconData icon;
  final Color iconColor;
  final Color iconBackground;

  const _ActivityLogItem({
    required this.title,
    required this.description,
    required this.dateTime,
    required this.icon,
    required this.iconColor,
    required this.iconBackground,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: iconBackground,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF111827),
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    color: Color(0xFF4B5563),
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  dateTime,
                  style: const TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActivityStatCard extends StatelessWidget {
  final String label;
  final String value;
  final Color background;
  final Color foreground;

  const _ActivityStatCard({
    required this.label,
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
            label,
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
