import 'package:flutter/material.dart';
import 'package:sina_mobile/View/Lib/Colors.dart';
import 'package:sina_mobile/View/Lib/DateFormatter.dart';

class StatusTugas extends StatelessWidget{
  final String judul;
  final DateTime uploadDate;
  final DateTime tenggat;
  final String sudahDikumpul;
  final String belumDikumpul;
  final String terlambat;

  const StatusTugas({
    super.key,
    required this.judul,
    required this.uploadDate,
    required this.tenggat,
    required this.sudahDikumpul,
    required this.belumDikumpul,
    required this.terlambat
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(judul, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                  Icon(Icons.more_vert)
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
                  Text(DateFormatter.format(uploadDate))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Tenggat"),
                  Text(DateFormatter.format(tenggat))
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
                      Text(sudahDikumpul),
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
                      Text(belumDikumpul),
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
                      Text(terlambat),
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
    );
  }

}