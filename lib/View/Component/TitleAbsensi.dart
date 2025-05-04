import 'package:flutter/material.dart';
import 'package:sina_mobile/View/Lib/Colors.dart';

class TitleAbsensi extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      width: MediaQuery.of(context).size.width,
      height: 44,
      decoration: BoxDecoration(
          color: AppColors.primary
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Absensi", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),
            Row(
              children: [
                Text("H", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),),
                SizedBox(width: 37,),
                Text("S", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),),
                SizedBox(width: 37,),
                Text("I", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),),
                SizedBox(width: 37,),
                Text("A", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),),
                SizedBox(width: 20,)
              ],
            )
          ],
        )
      ),
    );
  }


}