import 'package:flutter/material.dart';

class ItemStatistikSiswa extends StatelessWidget{
  final VoidCallback ontap;
  final String no;
  final String nama;

  const ItemStatistikSiswa({super.key, required this.no, required this.nama, required this.ontap});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          height: 50,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(no),
              Text(nama),
              Row(
                children: [
                  Text("Lihat nilai"),
                  Icon(Icons.arrow_forward_ios)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

}