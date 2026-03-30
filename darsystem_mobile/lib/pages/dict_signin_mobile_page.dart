import 'package:flutter/material.dart';
import '../widgets/logo_container.dart';
import '../widgets/signin_form.dart';

class DictSignInMobilePage extends StatelessWidget {
  const DictSignInMobilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF081B33),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 24,
                ),
                child: Column(
                  children: const [
                    SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LogoContainer(imagePath: 'assets/images/dict_logo.png'),
                        SizedBox(width: 16),
                        LogoContainer(
                          imagePath: 'assets/images/bagong_pilipinas.png',
                        ),
                      ],
                    ),
                    SizedBox(height: 28),
                    Text(
                      'Department of Information and\nCommunications Technology',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                        height: 1.35,
                      ),
                    ),
                    SizedBox(height: 32),
                    Divider(color: Colors.white24, thickness: 1, height: 1),
                    SizedBox(height: 32),
                    SignInForm(),
                    SizedBox(height: 40),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 8),
              child: Text(
                '© DICT PO1 2026. All Rights Reserved',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
