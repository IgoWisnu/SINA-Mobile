import 'package:flutter/material.dart';
import 'package:sina_mobile/View/Lib/Colors.dart';

class TitleBarLine extends StatelessWidget{
  final String judul;

  const TitleBarLine({super.key, required this.judul});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: AppColors.primary, // Set your desired color
                width: 4.0,         // Set your desired width
              ),
            )
        ),
        child: Text(judul, style: TextStyle(fontSize: 18),)
    );
  }

}