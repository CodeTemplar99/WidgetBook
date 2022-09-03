import 'package:flutter/material.dart';

SnackBar customSnackBar(String message, Color feedbackColor) => SnackBar(
      elevation: 0,
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 10,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      behavior: SnackBarBehavior.floating,
      backgroundColor: feedbackColor,
      content: Text(
        message,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
      duration: const Duration(milliseconds: 1800),
    );

void showFeedback(BuildContext context, String message, Color feedbackColor) {
  ScaffoldMessenger.of(context)
      .showSnackBar(customSnackBar(message, feedbackColor));
}
