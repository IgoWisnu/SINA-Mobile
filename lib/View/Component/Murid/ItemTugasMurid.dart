import 'package:flutter/material.dart';
import 'package:sina_mobile/View/Lib/Colors.dart';
import 'package:sina_mobile/View/Murid/DetailMateriMurid.dart';
import 'package:sina_mobile/View/TugasDetail.dart';

class ItemTugasMurid extends StatelessWidget{

  const ItemTugasMurid({
    super.key,

  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailMateriMurid()),
        );
      },
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
                  Text("Tugas 1 Javascript", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                  Text("20/28")
                ],
              ),
              SizedBox(height: 14,),
              Container(
                child: Row(
                  children: [
                    Icon(Icons.arrow_upward_outlined),
                    SizedBox(width: 5,),
                    Text("data")
                  ],
                ),
              ),
              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Icon(Icons.access_time),
                        SizedBox(width: 5,),
                        Text("data")
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.primary
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text("Tugas", style: TextStyle(color: Colors.white),),
                    ),
                  )
                ],
              ),

            ],
          ),
        ),

      ),
    );
  }

}