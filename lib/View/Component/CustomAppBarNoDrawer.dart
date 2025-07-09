import 'package:flutter/material.dart';

import '../Lib/Colors.dart';

class CustomAppBarNoDrawer extends StatelessWidget implements PreferredSizeWidget {

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
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.6),
                          blurRadius: 12,
                          spreadRadius: 1,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
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
