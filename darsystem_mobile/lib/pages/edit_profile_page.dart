import 'package:flutter/material.dart';
import '../widgets/logo_container.dart';
import 'home_page.dart';
import 'dashboard_page.dart';
import 'profile_page.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _fullNameController = TextEditingController(
    text: 'Louis Ramat',
  );
  final TextEditingController _emailController = TextEditingController(
    text: 'dict.user@dict.gov.ph',
  );
  final TextEditingController _officeController = TextEditingController(
    text: 'DICT Pangasinan Provincial Office',
  );
  final TextEditingController _positionController = TextEditingController(
    text: 'ICT Officer / Staff',
  );
  final TextEditingController _roleController = TextEditingController(
    text: 'User',
  );
  final TextEditingController _contactController = TextEditingController(
    text: '09123456789',
  );

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _officeController.dispose();
    _positionController.dispose();
    _roleController.dispose();
    _contactController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile updated successfully.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDCDCDC),
      body: SafeArea(
        child: Column(
          children: [
            const _EditProfileTopBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeaderCard(),
                    const SizedBox(height: 18),
                    _buildFormCard(),
                    const SizedBox(height: 18),
                    _buildActionButtons(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderCard() {
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
            child: Text(
              'LR',
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(height: 14),
          Text(
            'Edit Profile',
            style: TextStyle(
              color: Color(0xFF111827),
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Update your personal and account information',
            textAlign: TextAlign.center,
            style: TextStyle(color: Color(0xFF6B7280), fontSize: 13.5),
          ),
        ],
      ),
    );
  }

  Widget _buildFormCard() {
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
            'Profile Information',
            style: TextStyle(
              color: Color(0xFF111827),
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          _buildField(
            label: 'Full Name',
            controller: _fullNameController,
            icon: Icons.person_outline,
          ),
          const SizedBox(height: 14),
          _buildField(
            label: 'Email Address',
            controller: _emailController,
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 14),
          _buildField(
            label: 'Office',
            controller: _officeController,
            icon: Icons.business_outlined,
          ),
          const SizedBox(height: 14),
          _buildField(
            label: 'Position',
            controller: _positionController,
            icon: Icons.badge_outlined,
          ),
          const SizedBox(height: 14),
          _buildField(
            label: 'Role',
            controller: _roleController,
            icon: Icons.verified_user_outlined,
          ),
          const SizedBox(height: 14),
          _buildField(
            label: 'Contact Number',
            controller: _contactController,
            icon: Icons.phone_outlined,
            keyboardType: TextInputType.phone,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              );
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF0C4C7F),
              side: const BorderSide(color: Color(0xFF0C4C7F)),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text(
              'Cancel',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: _saveProfile,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0C4C7F),
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text(
              'Save Changes',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF374151),
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: const Color(0xFF6B7280)),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFF0C4C7F)),
            ),
          ),
        ),
      ],
    );
  }
}

class _EditProfileTopBar extends StatelessWidget {
  const _EditProfileTopBar();

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
          const _NavButton(label: 'Edit', isActive: true),
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
