import 'package:flutter/material.dart';
import '../widgets/logo_container.dart';
import 'home_page.dart';
import 'dashboard_page.dart';
import 'profile_page.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDCDCDC),
      body: SafeArea(
        child: Column(
          children: [
            const _NotificationsTopBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    _NotificationsHeaderCard(),
                    SizedBox(height: 18),
                    _NotificationSummarySection(),
                    SizedBox(height: 18),
                    _NotificationsListSection(),
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

class _NotificationsTopBar extends StatelessWidget {
  const _NotificationsTopBar();

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
          const _NavButton(label: 'Notifications', isActive: true),
        ],
      ),
    );
  }
}

class _NotificationsHeaderCard extends StatelessWidget {
  const _NotificationsHeaderCard();

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
              Icons.notifications_none,
              color: Colors.white,
              size: 34,
            ),
          ),
          SizedBox(height: 14),
          Text(
            'Notifications',
            style: TextStyle(
              color: Color(0xFF111827),
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Stay updated with report approvals, reminders, and account activity.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Color(0xFF6B7280), fontSize: 13.5),
          ),
        ],
      ),
    );
  }
}

class _NotificationSummarySection extends StatelessWidget {
  const _NotificationSummarySection();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: _SummaryCard(
            title: 'All',
            value: '12',
            background: Color(0xFFEDE9FE),
            foreground: Color(0xFF6D28D9),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: _SummaryCard(
            title: 'Unread',
            value: '5',
            background: Color(0xFFDBEAFE),
            foreground: Color(0xFF1D4ED8),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: _SummaryCard(
            title: 'Today',
            value: '3',
            background: Color(0xFFDCFCE7),
            foreground: Color(0xFF166534),
          ),
        ),
      ],
    );
  }
}

class _NotificationsListSection extends StatelessWidget {
  const _NotificationsListSection();

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
            'Recent Notifications',
            style: TextStyle(
              color: Color(0xFF111827),
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 16),
          _NotificationCard(
            title: 'Report Approved',
            message: 'Your Daily Accomplishment Report was approved.',
            time: 'Today • 9:12 AM',
            icon: Icons.check_circle_outline,
            iconBackground: Color(0xFFDCFCE7),
            iconColor: Color(0xFF166534),
            isUnread: true,
          ),
          _NotificationCard(
            title: 'Revision Requested',
            message: 'Monthly Summary Report needs correction.',
            time: 'Today • 8:40 AM',
            icon: Icons.edit_note,
            iconBackground: Color(0xFFFEE2E2),
            iconColor: Color(0xFF991B1B),
            isUnread: true,
          ),
          _NotificationCard(
            title: 'Submission Received',
            message: 'Your Weekly Report was submitted successfully.',
            time: 'Yesterday • 4:18 PM',
            icon: Icons.upload_file_outlined,
            iconBackground: Color(0xFFDBEAFE),
            iconColor: Color(0xFF1D4ED8),
          ),
          _NotificationCard(
            title: 'Reminder',
            message: 'Do not forget to submit your report before 5:00 PM.',
            time: 'Yesterday • 10:00 AM',
            icon: Icons.notifications_active_outlined,
            iconBackground: Color(0xFFFEF3C7),
            iconColor: Color(0xFF92400E),
          ),
          _NotificationCard(
            title: 'Account Security',
            message: 'Your password was changed successfully.',
            time: 'April 5, 2026 • 7:24 PM',
            icon: Icons.lock_outline,
            iconBackground: Color(0xFFEDE9FE),
            iconColor: Color(0xFF6D28D9),
          ),
        ],
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  final String title;
  final String message;
  final String time;
  final IconData icon;
  final Color iconBackground;
  final Color iconColor;
  final bool isUnread;

  const _NotificationCard({
    required this.title,
    required this.message,
    required this.time,
    required this.icon,
    required this.iconBackground,
    required this.iconColor,
    this.isUnread = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isUnread ? const Color(0xFFF9FBFF) : Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isUnread ? const Color(0xFFD6E4FF) : const Color(0xFFE5E7EB),
        ),
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
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          color: Color(0xFF111827),
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    if (isUnread)
                      Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          color: Color(0xFF2563EB),
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  message,
                  style: const TextStyle(
                    color: Color(0xFF4B5563),
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  time,
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

class _SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final Color background;
  final Color foreground;

  const _SummaryCard({
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
