import 'package:flutter/material.dart';
import 'package:sina_mobile/View/Lib/Colors.dart';

class Box extends StatelessWidget{
  final int jumlah;
  final String keterangan;

  const Box({
    super.key,
    required this.jumlah,
    required this.keterangan
});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        height: 130,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(jumlah.toString(), style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),),
              Text(keterangan, style: TextStyle(fontSize:14,fontWeight: FontWeight.bold ,color: Colors.white),)
            ],
          ),
        ),
      ),
    );
  }

}