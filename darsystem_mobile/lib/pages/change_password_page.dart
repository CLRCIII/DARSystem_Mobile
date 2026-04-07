import 'package:flutter/material.dart';
import '../widgets/logo_container.dart';
import 'home_page.dart';
import 'dashboard_page.dart';
import 'profile_page.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _showCurrentPassword = false;
  bool _showNewPassword = false;
  bool _showConfirmPassword = false;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _updatePassword() {
    final currentPassword = _currentPasswordController.text.trim();
    final newPassword = _newPasswordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (currentPassword.isEmpty ||
        newPassword.isEmpty ||
        confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all password fields.')),
      );
      return;
    }

    if (newPassword != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('New password and confirm password do not match.'),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Password changed successfully.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDCDCDC),
      body: SafeArea(
        child: Column(
          children: [
            const _ChangePasswordTopBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeaderCard(),
                    const SizedBox(height: 18),
                    _buildPasswordFormCard(),
                    const SizedBox(height: 18),
                    _buildPasswordTipsCard(),
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
            child: Icon(Icons.lock_outline, color: Colors.white, size: 34),
          ),
          SizedBox(height: 14),
          Text(
            'Change Password',
            style: TextStyle(
              color: Color(0xFF111827),
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Update your account password to keep your profile secure.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Color(0xFF6B7280), fontSize: 13.5),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordFormCard() {
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
            'Password Details',
            style: TextStyle(
              color: Color(0xFF111827),
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          _buildPasswordField(
            label: 'Current Password',
            controller: _currentPasswordController,
            obscureText: !_showCurrentPassword,
            onToggleVisibility: () {
              setState(() {
                _showCurrentPassword = !_showCurrentPassword;
              });
            },
            visible: _showCurrentPassword,
          ),
          const SizedBox(height: 14),
          _buildPasswordField(
            label: 'New Password',
            controller: _newPasswordController,
            obscureText: !_showNewPassword,
            onToggleVisibility: () {
              setState(() {
                _showNewPassword = !_showNewPassword;
              });
            },
            visible: _showNewPassword,
          ),
          const SizedBox(height: 14),
          _buildPasswordField(
            label: 'Confirm New Password',
            controller: _confirmPasswordController,
            obscureText: !_showConfirmPassword,
            onToggleVisibility: () {
              setState(() {
                _showConfirmPassword = !_showConfirmPassword;
              });
            },
            visible: _showConfirmPassword,
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordTipsCard() {
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
            'Password Tips',
            style: TextStyle(
              color: Color(0xFF111827),
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 14),
          _TipRow(text: 'Use at least 8 characters'),
          SizedBox(height: 10),
          _TipRow(text: 'Include uppercase and lowercase letters'),
          SizedBox(height: 10),
          _TipRow(text: 'Add numbers or special characters'),
          SizedBox(height: 10),
          _TipRow(text: 'Avoid using common or easy-to-guess passwords'),
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
            onPressed: _updatePassword,
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
              'Update Password',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField({
    required String label,
    required TextEditingController controller,
    required bool obscureText,
    required VoidCallback onToggleVisibility,
    required bool visible,
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
          obscureText: obscureText,
          decoration: InputDecoration(
            prefixIcon: const Icon(
              Icons.lock_outline,
              color: Color(0xFF6B7280),
            ),
            suffixIcon: IconButton(
              onPressed: onToggleVisibility,
              icon: Icon(
                visible ? Icons.visibility_off : Icons.visibility,
                color: const Color(0xFF6B7280),
              ),
            ),
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

class _ChangePasswordTopBar extends StatelessWidget {
  const _ChangePasswordTopBar();

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
          const _NavButton(label: 'Password', isActive: true),
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

class _TipRow extends StatelessWidget {
  final String text;

  const _TipRow({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 2),
          child: Icon(Icons.check_circle, color: Color(0xFF0C4C7F), size: 18),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: Color(0xFF4B5563),
              fontSize: 13.5,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
