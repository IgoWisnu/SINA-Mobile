import 'package:flutter/material.dart';
import 'package:sina_mobile/View/DetailTugasSiswa.dart';

class ItemTugasSiswa extends StatelessWidget{
  final String nama;
  final VoidCallback ontap;

  const ItemTugasSiswa({super.key, required this.nama, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
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