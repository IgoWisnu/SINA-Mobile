import 'package:flutter/material.dart';

class CustomTextArea extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int minLines;
  final int maxLines;

  const CustomTextArea({
    Key? key,
    required this.controller,
    this.hintText = '',
    this.minLines = 5, // default minimal 5 baris
    this.maxLines = 10, // default maksimal 10 baris
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
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
          borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2),
        ),
      ),
    );
  }
}
