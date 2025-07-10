import 'package:flutter/material.dart';
import 'package:sina_mobile/View/Component/OrangTua/LineBar.dart';
import 'package:sina_mobile/View/Lib/WaktuFormatter.dart';

class ItemJadwalOrtu extends StatelessWidget {
  final String waktu_mulai;
  final String mata_pelajaran;
  final String waktu_selesai;
  final String guru;

  const ItemJadwalOrtu({
    super.key,
    required this.waktu_mulai,
    required this.mata_pelajaran,
    required this.waktu_selesai,
    required this.guru,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Waktu
              SizedBox(
                width: 60,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(waktu_mulai, style: const TextStyle(fontSize: 14)),
                    Text(waktu_selesai, style: const TextStyle(fontSize: 14)),
                  ],
                ),
              ),

              const SizedBox(width: 80),

              // Mata Pelajaran
              Expanded(
                child: Text(
                  mata_pelajaran,
                  style: const TextStyle(fontSize: 14),
                ),
              ),

              SizedBox(width: 65),

              // Guru
              Expanded(child: Text(guru, style: const TextStyle(fontSize: 14))),
            ],
          ),

          const SizedBox(height: 8),

          // Garis bawah
          const Divider(thickness: 1),
        ],
      ),
    );
  }
}
