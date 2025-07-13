import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool enabled;
  final IconData? prefixIcon;
  final EdgeInsetsGeometry? contentPadding;
  final Color? iconColor;
  final double? iconSize;

  const CustomTextField({
    Key? key,
    required this.controller,
    this.hintText = '',
    this.enabled = true,
    this.prefixIcon,
    this.contentPadding,
    this.iconColor,
    this.iconSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final disabledTextColor = Colors.grey.shade600;
    final disabledBgColor = Colors.grey.shade200;
    final defaultIconColor = enabled ? Colors.grey.shade600 : disabledTextColor;

    return TextField(
      controller: controller,
      enabled: enabled,
      style: TextStyle(color: enabled ? Colors.black : disabledTextColor),
      decoration: InputDecoration(
        hintText: hintText,
        filled: !enabled,
        fillColor: !enabled ? disabledBgColor : null,
        contentPadding:
            contentPadding ??
            const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        prefixIcon:
            prefixIcon != null
                ? Padding(
                  padding: const EdgeInsets.only(left: 12, right: 8),
                  child: Icon(
                    prefixIcon,
                    color: iconColor ?? defaultIconColor,
                    size: iconSize ?? 24,
                  ),
                )
                : null,
      ),
    );
  }
}
