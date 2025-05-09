import 'package:flutter/material.dart';

class ItemRiwayatAbsensi extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Izin", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            Text("05/07/2025", style: TextStyle(),),
            Row(
              children: [
                Text("Surat Izin"),
                SizedBox(width: 3,),
                Icon(Icons.arrow_forward_ios)
              ],
            )
          ],
        ),
      ),
    );
  }

}