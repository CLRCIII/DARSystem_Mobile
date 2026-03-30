import 'package:flutter/material.dart';

class FeedbackMessage extends StatelessWidget {
  final String message;
  final bool isError;

  const FeedbackMessage({
    super.key,
    required this.message,
    required this.isError,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: isError
            ? Colors.red.withOpacity(0.16)
            : Colors.green.withOpacity(0.16),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isError ? Colors.redAccent : Colors.greenAccent,
        ),
      ),
      child: Text(
        message,
        style: TextStyle(
          color: isError ? Colors.redAccent : Colors.greenAccent,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
