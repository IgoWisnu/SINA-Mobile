import 'package:flutter/material.dart';
import 'package:sina_mobile/View/DetailTugasSiswa.dart';
import 'package:sina_mobile/View/Lib/Colors.dart';

class ItemTugasSiswa extends StatelessWidget{
  final String nama;
  final VoidCallback ontap;

  const ItemTugasSiswa({super.key, required this.nama, required this.ontap});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: ontap,
      child: Container(
        decoration: BoxDecoration(
          gradient: isDarkMode? AppColors.darkBlueGradientVertical : AppColors.lightBlueGradient,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1), // Shadow color with opacity
              spreadRadius: 2, // How far the shadow spreads
              blurRadius: 5,  // Softness of the shadow
              offset: Offset(0, 4), // Horizontal & Vertical offset
            ),
          ],
        ),
        height: 50,
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.file_copy),
                  SizedBox(width: 10,),
                  Text(nama)
                ],
              ),
              Icon(Icons.arrow_forward_ios)
            ],
          ),
        ),
      ),
    );
  }

}