import 'package:flutter/material.dart';
import 'package:sina_mobile/View/Lib/Colors.dart';

class StatusTugas extends StatelessWidget{

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
                  Text("Tugas javascript 1", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
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
                  Text("20/5/2025")
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Tenggat"),
                  Text("23/5/2025")
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
                      Text('3'),
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
                      Text('25'),
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
                      Text('0'),
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