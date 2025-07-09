import 'package:flutter/material.dart';
import 'package:sina_mobile/View/Lib/Colors.dart';
import 'package:sina_mobile/View/Lib/DateFormatter.dart';
import 'package:sina_mobile/View/Murid/DetailMateriMurid.dart';

class ItemTugas extends StatelessWidget{
  final judul;
  final upload_date;
  final tenggat;
  final dikumpul;
  final jumlahsiswa;
  final VoidCallback onTap;

  const ItemTugas({
    super.key,
    required this.judul,
    required this.upload_date,
    required this.tenggat,
    required this.dikumpul,
    required this.jumlahsiswa,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // TODO: implement build
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isDarkMode? AppColors.primary : Colors.black, // Set your desired color
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
                  Text("$dikumpul/$jumlahsiswa")
                ],
              ),
              SizedBox(height: 14,),
              Container(
                child: Row(
                  children: [
                    Icon(Icons.arrow_upward_outlined),
                    SizedBox(width: 5,),
                    Text(
                        DateFormatter.format(upload_date)
                    )
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
                        Text(
                            DateFormatter.format(tenggat)
                        )
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