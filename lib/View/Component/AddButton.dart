import 'package:flutter/material.dart';
import 'package:sina_mobile/View/Lib/Colors.dart';

class AddButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AddButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: AppColors.primary,
      elevation: 0,
      shadowColor: AppColors.primary.withOpacity(0.6),
      borderRadius: BorderRadius.circular(100),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.6),
              blurRadius: 12,
              spreadRadius: 1,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: onPressed,
          backgroundColor: AppColors.primary,
          elevation: 0, // Shadow handled by Container
          child: Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}
