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
                  Text("data", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
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
                  Text("Data"),
                  Text("12/3/2025")
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Data"),
                  Text("12/3/2025")
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Data"),
                  Row(
                    children: [
                      Text('0'),
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
                  Text("Data"),
                  Row(
                    children: [
                      Text('0'),
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
                  Text("Data"),
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