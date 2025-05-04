import 'package:flutter/material.dart';

class ItemJadwal extends StatelessWidget{
  final String waktu_mulai;
  final String waktu_selesai;
  final String mata_pelajaran;
  final String kelas;

  const ItemJadwal({
    super.key,
    required this.waktu_mulai,
    required this.waktu_selesai,
    required this.mata_pelajaran,
    required this.kelas,
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
            Text(kelas)
          ],
        ),
      ),
    );
  }

}