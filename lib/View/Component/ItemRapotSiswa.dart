import 'package:flutter/material.dart';
import 'package:sina_mobile/View/RapotSiswaDetail.dart';

class ItemRapotSiswa extends StatelessWidget{
  final String no;
  final String nama;

  const ItemRapotSiswa({super.key, required this.no, required this.nama});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => RapotSiswaDetail()));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(no),
              Text(nama),
              Row(
               children: [
                 Container(
                   height: 13,
                   width: 13,
                   decoration: BoxDecoration(
                     color: Colors.red,
                       borderRadius: BorderRadius.circular(13)
                   ),
                 ),
                 SizedBox(width: 3,),
                 Text("Belum"),
                 SizedBox(width: 3,),
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