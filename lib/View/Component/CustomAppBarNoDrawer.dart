import 'package:flutter/material.dart';
import '../Lib/Colors.dart';

class CustomAppBarNoDrawer extends StatelessWidget
    implements PreferredSizeWidget {
  final Color? backgroundColor;
  final Color? backButtonColor;
  final Color? iconColor;
  final double? elevation;
  final VoidCallback? onBackPressed;
  final IconThemeData? iconTheme;

  const CustomAppBarNoDrawer({
    Key? key,
    this.backgroundColor,
    this.backButtonColor,
    this.iconColor,
    this.elevation,
    this.onBackPressed,
    this.iconTheme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Material(
          elevation: elevation ?? 2,
          borderRadius: BorderRadius.circular(16),
          shadowColor: Colors.black.withOpacity(0.2),
          child: Container(
            height: 64,
            decoration: BoxDecoration(
              color: backgroundColor ?? AppColors.blueDisable,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Material(
                    borderRadius: BorderRadius.circular(12),
                    color: backButtonColor ?? Colors.blue[700],
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: onBackPressed ?? () => Navigator.pop(context),
                      child: Container(
                        width: 48,
                        height: 48,
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.arrow_back,
                          color: iconColor ?? Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Image.asset(
                    'lib/asset/image/SINA.png',
                    height: 40,
                    width: 40,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80); // 64 + 16 (padding)
}
