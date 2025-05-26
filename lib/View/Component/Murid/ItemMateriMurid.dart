import 'package:flutter/material.dart';
import 'package:sina_mobile/View/Lib/Colors.dart';

class ItemMateriMurid extends StatelessWidget{
  final judul;
  final upload_date;
  final VoidCallback onTap;

  const ItemMateriMurid({
    super.key,
    required this.judul,
    required this.upload_date,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.black, // Set your desired color
              width: 2.0,         // Set your desired width
            ),
          ),
        ),
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(judul, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                  Text("")
                ],
              ),
              SizedBox(height: 14,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Icon(Icons.arrow_upward_outlined),
                        SizedBox(width: 5,),
                        Text(upload_date.toString())
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.green
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text("Materi", style: TextStyle(color: Colors.white),),
                    ),
                  )
                ],
              ),
              SizedBox(height: 5,),

            ],
          ),
        ),

      ),
    );
  }

}