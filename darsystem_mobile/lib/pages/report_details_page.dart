import 'package:flutter/material.dart';
import '../widgets/logo_container.dart';
import 'home_page.dart';
import 'dashboard_page.dart';
import 'profile_page.dart';

class ReportDetailsPage extends StatelessWidget {
  const ReportDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    const String status = 'Approved';
    final _StatusStyle statusStyle = _getStatusStyle(status);

    return Scaffold(
      backgroundColor: const Color(0xFFDCDCDC),
      body: SafeArea(
        child: Column(
          children: [
            const _ReportDetailsTopBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeaderCard(status, statusStyle),
                    const SizedBox(height: 18),
                    _buildReportInfoCard(status, statusStyle),
                    const SizedBox(height: 18),
                    _buildDescriptionCard(),
                    const SizedBox(height: 18),
                    _buildReviewerRemarksCard(),
                    const SizedBox(height: 18),
                    _buildActionButtons(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderCard(String status, _StatusStyle statusStyle) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 42,
            backgroundColor: Color(0xFF0C4C7F),
            child: Icon(
              Icons.description_outlined,
              color: Colors.white,
              size: 34,
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            'Report Details',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF111827),
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'View the complete information of your submitted accomplishment report.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Color(0xFF6B7280), fontSize: 13.5),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: statusStyle.background,
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              status,
              style: TextStyle(
                color: statusStyle.foreground,
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReportInfoCard(String status, _StatusStyle statusStyle) {
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
            'Report Information',
            style: TextStyle(
              color: Color(0xFF111827),
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 16),
          _DetailRow(
            label: 'Report Title',
            value: 'Daily Accomplishment Report',
          ),
          SizedBox(height: 12),
          _DetailRow(label: 'File Name', value: 'DAR_March_25.pdf'),
          SizedBox(height: 12),
          _DetailRow(label: 'Report Type', value: 'Daily'),
          SizedBox(height: 12),
          _DetailRow(label: 'Submitted Date', value: 'March 25, 2026'),
          SizedBox(height: 12),
          _DetailRow(label: 'Submitted Time', value: '9:12 AM'),
          SizedBox(height: 12),
          _DetailRow(label: 'Prepared By', value: 'Louis Ramat'),
          SizedBox(height: 12),
          _DetailRow(
            label: 'Office',
            value: 'DICT Pangasinan Provincial Office',
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionCard() {
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
            'Description',
            style: TextStyle(
              color: Color(0xFF111827),
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 14),
          Text(
            'This report contains the completed daily accomplishments, assigned tasks, and progress updates submitted for monitoring and performance tracking.',
            style: TextStyle(
              color: Color(0xFF4B5563),
              fontSize: 13.5,
              height: 1.7,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewerRemarksCard() {
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
            'Reviewer Remarks',
            style: TextStyle(
              color: Color(0xFF111827),
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 14),
          Text(
            'Your report has been reviewed and approved. The submission is complete and properly documented.',
            style: TextStyle(
              color: Color(0xFF4B5563),
              fontSize: 13.5,
              height: 1.7,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.visibility_outlined),
          label: const Text('View File'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0C4C7F),
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.download_outlined),
          label: const Text('Download'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0C4C7F),
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        OutlinedButton.icon(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
          label: const Text('Back'),
          style: OutlinedButton.styleFrom(
            foregroundColor: const Color(0xFF0C4C7F),
            side: const BorderSide(color: Color(0xFF0C4C7F)),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ],
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

class _ReportDetailsTopBar extends StatelessWidget {
  const _ReportDetailsTopBar();

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
          const _NavButton(label: 'Details', isActive: true),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            label,
            style: const TextStyle(
              color: Color(0xFF6B7280),
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              color: Color(0xFF111827),
              fontSize: 13.5,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
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
