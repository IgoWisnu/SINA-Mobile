import 'package:flutter/material.dart';
import 'package:sina_mobile/Model/Guru/TugasDetailResponse.dart';
import 'package:sina_mobile/Model/Guru/TugasGuru.dart';
import 'package:sina_mobile/View/Lib/Colors.dart';
import 'package:sina_mobile/View/Lib/DateFormatter.dart';

class StatusTugas extends StatelessWidget{
  final TugasDetail tugas;
  final VoidCallback? action;
  final GlobalKey? menuKey;

  const StatusTugas({
    super.key,
    required this.tugas,
    this.action,
    required this.menuKey
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // TODO: implement build
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: isDarkMode? AppColors.darkBlueGradientVertical :AppColors.lightBlueGradient,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(tugas.judul?? '', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                      IconButton(
                        key: menuKey, // pasang key di sini
                        icon: Icon(Icons.more_vert),
                        onPressed: action ?? (){},
                      )
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 5,
                  decoration: BoxDecoration(
                    color: AppColors.primary
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Diunggah"),
                      Text(DateFormatter.format(tugas.createdAt?? DateTime.now()))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Tenggat"),
                      Text(DateFormatter.format(tugas.tenggatKumpul?? DateTime.now()))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Sudah dikumpulkan"),
                      Row(
                        children: [
                          Text(tugas.jumlahDikumpulkan.toString()),
                          SizedBox(width: 5,),
                          Icon(Icons.people)
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Belum dikumpulkan"),
                      Row(
                        children: [
                          Text({tugas.jumlahSiswa-tugas.jumlahDikumpulkan}.toString()),
                          SizedBox(width: 5,),
                          Icon(Icons.people)
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Terlambat"),
                      Row(
                        children: [
                          Text(tugas.jumlahTerlambat.toString()),
                          SizedBox(width: 5,),
                          Icon(Icons.people)
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
      ),
    );
  }

}