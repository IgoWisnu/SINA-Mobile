import 'package:flutter/material.dart';

class ItemJadwalMurid extends StatelessWidget{
  final String waktu_mulai;
  final String waktu_selesai;
  final String mata_pelajaran;
  final String guru;

  const ItemJadwalMurid({
    super.key,
    required this.waktu_mulai,
    required this.waktu_selesai,
    required this.mata_pelajaran,
    required this.guru,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 50,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(waktu_mulai),
                Text(waktu_selesai)
              ],
            ),
            Text(mata_pelajaran),
            Text(guru)
          ],
        ),
      ),
    );
  }

}