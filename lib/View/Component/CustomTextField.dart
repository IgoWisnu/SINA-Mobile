import 'package:flutter/material.dart';
import 'package:sina_mobile/View/Lib/Colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool enabled;

  const CustomTextField({
    Key? key,
    required this.controller,
    this.hintText = '',
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final disabledTextColor = Colors.grey.shade600;
    final disabledBgColor = Colors.grey.shade200;

    return TextField(
      controller: controller,
      enabled: enabled,
      style: TextStyle(
        color: enabled ? isDarkMode? Colors.white : Colors.black : isDarkMode? Colors.white : disabledTextColor,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        filled: !enabled, // Aktifkan warna latar belakang hanya saat disabled
        fillColor: !enabled ? isDarkMode? AppColors.dark : disabledBgColor : null,
        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
      ),
    );
  }
}
