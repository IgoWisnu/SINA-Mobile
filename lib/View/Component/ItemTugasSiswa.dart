import 'package:flutter/material.dart';
import 'package:sina_mobile/View/DetailTugasSiswa.dart';

class ItemTugasSiswa extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailTugasSiswa()
        ));
      },
      child: Container(
        height: 50,
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.file_copy),
                  SizedBox(width: 10,),
                  Text("data")
                ],
              ),
              Icon(Icons.arrow_forward_ios)
            ],
          ),
        ),
      ),
    );
  }

}