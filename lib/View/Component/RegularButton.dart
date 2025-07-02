import 'package:flutter/material.dart';
import 'package:sina_mobile/View/Lib/Colors.dart';

 class RegularButton extends StatelessWidget{
   final VoidCallback onTap;
   final String judul;
   final Color color;

   const RegularButton({
    super.key,
    required this.onTap,
    required this.judul,
     this.color = AppColors.primary
 });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
            borderRadius: BorderRadius.circular(12)
        ),
        width: MediaQuery.of(context).size.width,
        height: 50,
        child: Text(judul, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),),
      ),
    );
  }


 }