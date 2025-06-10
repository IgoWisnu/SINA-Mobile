import 'package:flutter/material.dart';
import 'package:sina_mobile/View/Lib/WaktuFormatter.dart';

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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(WaktuFormatter.format(waktu_mulai)),
                Text(WaktuFormatter.format(waktu_selesai))
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