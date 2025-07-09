import 'package:flutter/material.dart';
import 'package:sina_mobile/View/Lib/Colors.dart';

class TitleBar extends StatelessWidget{
  final String judul;

  const TitleBar({
   super.key,
   required this.judul
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      width: MediaQuery.of(context).size.width,
      height: 50,
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Text(judul, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),)
        ,
      ),
    );
  }


}