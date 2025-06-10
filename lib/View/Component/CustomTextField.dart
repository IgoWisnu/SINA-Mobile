import 'package:flutter/material.dart';

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
    final disabledTextColor = Colors.grey.shade600;
    final disabledBgColor = Colors.grey.shade200;

    return TextField(
      controller: controller,
      enabled: enabled,
      style: TextStyle(
        color: enabled ? Colors.black : disabledTextColor,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        filled: !enabled, // Aktifkan warna latar belakang hanya saat disabled
        fillColor: !enabled ? disabledBgColor : null,
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
          borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
      ),
    );
  }
}
