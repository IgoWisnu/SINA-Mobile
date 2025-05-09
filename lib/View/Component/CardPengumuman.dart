import 'package:flutter/material.dart';

class CardPengumuman extends StatelessWidget{
  final VoidCallback Action;

  const CardPengumuman({super.key, required this.Action});


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: Action,
      child: Card(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              children: [
                Container(
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12)
                  ),
                  child: Ink.image(
                    image: AssetImage('lib/asset/image/pengumuman.png'),
                    height: 250,
                    fit: BoxFit.fill,)
                ),
                SizedBox(height: 10,),
                Text("Menjelang Hari Raya Nyepi, Siswa Libur 2 Minggu", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                SizedBox(height: 5,),
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore..."),
                SizedBox(height: 10,),
                Container(
                  alignment: Alignment.topRight,
                  child: Text("14 Jan 2025", style: TextStyle(color: Colors.grey),),
                )
              ],
            ),
          ),

        ),
      ),
    );
  }
  
}