import 'package:flutter/material.dart';
import 'package:sina_mobile/View/Lib/Colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onMenuPressed;

  const CustomAppBar({super.key, required this.onMenuPressed});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          height: 64,
          decoration: BoxDecoration(
            color: AppColors.blueDisable,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: IconButton(
                  icon: const Icon(Icons.menu, color: Colors.black, size: 40),
                  onPressed: onMenuPressed,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Image.asset(
                  'lib/asset/image/SINA.png',
                  height: 45,
                  width: 45,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(74 + 16);
}
