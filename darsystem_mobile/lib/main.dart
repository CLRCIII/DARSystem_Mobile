import 'package:flutter/material.dart';
import 'pages/dict_signin_mobile_page.dart';

void main() {
  runApp(const DictApp());
}

class DictApp extends StatelessWidget {
  const DictApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DictSignInMobilePage(),
    );
  }
}
