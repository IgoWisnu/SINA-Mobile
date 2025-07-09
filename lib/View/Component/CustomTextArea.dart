import 'package:flutter/material.dart';
import 'package:sina_mobile/View/Lib/Colors.dart';

class CustomTextArea extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int minLines;
  final int maxLines;
  final bool disable;

  const CustomTextArea({
    Key? key,
    required this.controller,
    this.hintText = '',
    this.minLines = 5,
    this.maxLines = 10,
    this.disable = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return TextField(
      readOnly: disable,
      controller: controller,
      minLines: minLines,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
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
          borderSide: BorderSide(color: AppColors.primary)
        ),
        filled: disable,
        fillColor: disable ? isDarkMode? AppColors.dark : Colors.grey.shade300 : Colors.white,
      ),
      style: TextStyle(
        color: disable ? isDarkMode? Colors.white : Colors.grey.shade800 : isDarkMode? Colors.white : Colors.black,
      ),
    );
  }
}
