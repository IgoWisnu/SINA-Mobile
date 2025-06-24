import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomSnackbar {
  static void showSuccess(BuildContext context, String message) {
    _show(
      context,
      message,
      lottieAsset: 'assets/animations/success.json',
    );
  }

  static void showError(BuildContext context, String message) {
    _show(
      context,
      message,
      lottieAsset: 'assets/animations/failed.json',
    );
  }

  static void _show(
      BuildContext context,
      String message, {
        required String lottieAsset,
      }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        width: double.infinity,
        content: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
          ),
          child: Row(
            children: [
              Lottie.asset(
                lottieAsset,
                width: 60,
                height: 60,
                repeat: false,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
