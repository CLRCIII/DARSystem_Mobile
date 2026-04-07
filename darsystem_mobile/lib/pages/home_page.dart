import 'package:flutter/material.dart';
import '../widgets/logo_container.dart';
import 'dashboard_page.dart';
import 'profile_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDEDED),
      body: SafeArea(
        child: Column(
          children: [
            const _HomeTopBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeroSection(context),
                    const SizedBox(height: 24),
                    _buildFeatureGrid(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(width: 3, height: 120, color: const Color(0xFF242424)),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Daily Accomplishment\nRecords System',
                      style: TextStyle(
                        color: Color(0xFF25282D),
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        height: 1.02,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'A web-based system that records, monitors, and summarizes the daily accomplishments of DICT personnel for efficient reporting and performance tracking.',
                      style: TextStyle(
                        color: Color(0xFF686D73),
                        fontSize: 14,
                        height: 1.8,
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      height: 46,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DashboardPage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0C4C7F),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(999),
                          ),
                        ),
                        child: const Text(
                          'Get started',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),
          Center(
            child: SizedBox(
              width: 300,
              height: 240,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: 8,
                    child: Container(
                      width: 240,
                      height: 120,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xFFE3EBF5),
                          width: 22,
                        ),
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(240),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 28,
                    child: Container(
                      width: 190,
                      height: 96,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xFFD9E5F0),
                          width: 16,
                        ),
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(190),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 12,
                    child: Container(
                      width: 260,
                      height: 170,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(26),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.12),
                            blurRadius: 18,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Image.asset(
                        'assets/images/dictpang.jpg',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: const Color(0xFFD9E5F0),
                            alignment: Alignment.center,
                            child: const Text(
                              'DICT Office Image',
                              style: TextStyle(
                                color: Color(0xFF4E647A),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: 180,
                      height: 10,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(0, 0, 0, 0.10),
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureGrid(BuildContext context) {
    return Column(
      children: [
        _FeatureCard(
          title: 'Easy Report Submission',
          description:
              'Provides a user-friendly interface for recording daily accomplishments quickly and accurately.',
          icon: Icons.description_outlined,
          onTap: () {},
        ),
        const SizedBox(height: 14),
        _FeatureCard(
          title: 'Real-Time Monitoring',
          description:
              'Allows users and administrators to monitor submission status and pending approvals in real time.',
          icon: Icons.access_time,
          accent: true,
          onTap: () {},
        ),
        const SizedBox(height: 14),
        _FeatureCard(
          title: 'Automated Summary Reports',
          description:
              'Automatically compiles submitted data into organized weekly and monthly reports.',
          icon: Icons.article_outlined,
          onTap: () {},
        ),
        const SizedBox(height: 14),
        _FeatureCard(
          title: 'Secure Access',
          description:
              'Implements role-based authentication to ensure authorized access and accountability.',
          icon: Icons.shield_outlined,
          highlight: true,
          onTap: () {},
        ),
      ],
    );
  }
}

class _HomeTopBar extends StatelessWidget {
  const _HomeTopBar();

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
          _TopBarNavButton(label: 'Home', isActive: true, onTap: () {}),
          const SizedBox(width: 8),
          _TopBarNavButton(
            label: 'Dashboard',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DashboardPage()),
              );
            },
          ),
          const SizedBox(width: 10),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none, color: Colors.white),
          ),
          _TopBarNavButton(
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

class _TopBarNavButton extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _TopBarNavButton({
    required this.label,
    required this.onTap,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
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

class _FeatureCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final bool accent;
  final bool highlight;
  final VoidCallback onTap;

  const _FeatureCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.onTap,
    this.accent = false,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    Color background = Colors.white;

    if (accent) {
      background = const Color(0xFFEDF1F5);
    } else if (highlight) {
      background = const Color(0xFFD6E0EA);
    }

    return Material(
      color: background,
      borderRadius: BorderRadius.circular(22),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: const Color(0xFFD8DCE2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: const Color(0xFF0C4C7F),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: Colors.white, size: 24),
              ),
              const SizedBox(height: 14),
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF25282D),
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: const TextStyle(
                  color: Color(0xFF686D73),
                  fontSize: 13.5,
                  height: 1.6,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
