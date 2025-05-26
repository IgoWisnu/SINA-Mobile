import 'package:flutter/material.dart';
import 'package:sina_mobile/View/Lib/Colors.dart';

 class RegularButton extends StatelessWidget{
   final VoidCallback onTap;
   final String judul;

   const RegularButton({
    super.key,
    required this.onTap,
    required this.judul
 });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.primary,
            borderRadius: BorderRadius.circular(12)
        ),
        width: MediaQuery.of(context).size.width,
        height: 50,
        child: Text(judul, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),),
      ),
    );
  }


 }