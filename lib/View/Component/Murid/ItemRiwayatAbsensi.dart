import 'package:flutter/material.dart';

class ItemRiwayatAbsensi extends StatefulWidget{
  final String keterangan;
  final String tanggal;
  const ItemRiwayatAbsensi({super.key, required this.keterangan, required this.tanggal});

  @override
  State<ItemRiwayatAbsensi> createState() => _ItemRiwayatAbsensiState();
}

class _ItemRiwayatAbsensiState extends State<ItemRiwayatAbsensi> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.keterangan, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            Text(widget.tanggal, style: TextStyle(),),
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