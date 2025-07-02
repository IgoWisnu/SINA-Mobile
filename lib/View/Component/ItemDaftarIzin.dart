import 'package:flutter/material.dart';

class ItemDaftarIzin extends StatelessWidget{
  final VoidCallback ontap;
  final String nama;
  final String kelas;
  final String tanggal;

  const ItemDaftarIzin({
    super.key,
    required this.nama,
    required this.kelas,
    required this.tanggal,
    required this.ontap,

  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: 50,
        width: double.infinity,
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(nama),
              Text(kelas),
              Text(tanggal),
              Row(
                children: [
                  Container(
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                      color: Colors.red, // Ganti sesuai kebutuhan
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 3,),
                  Text("Belum"),
                  SizedBox(width: 2,),
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