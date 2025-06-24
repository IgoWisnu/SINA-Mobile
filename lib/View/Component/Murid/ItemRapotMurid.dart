import 'package:flutter/material.dart';
import 'package:sina_mobile/View/Murid/RapotDetailMurid.dart';

class ItemRapotMurid extends StatelessWidget{
  final String kelas;
  final VoidCallback ontap;

  const ItemRapotMurid({super.key, required this.kelas, required this.ontap});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.black, width: 1)
          )
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(kelas),
              Text("I Gede Igo Wisnu W"),
              Icon(Icons.arrow_forward_ios)
            ],
          ),
        ),
      ),
    );
  }

}