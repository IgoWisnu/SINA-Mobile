import 'package:flutter/material.dart';

class ClassCardMurid extends StatelessWidget{
  final String judul;
  final String image;
  final String namaGuru;
  final VoidCallback onTap;

  const ClassCardMurid({
    super.key,
    required this.judul,
    required this.onTap,
    this.image = '',
    required this.namaGuru
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    String baseImageUrl = 'http://sina.pnb.ac.id:3000/Upload/profile_image/';

    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          children: [
            Ink.image(
              image: AssetImage('lib/asset/image/class_bg.png'),
              height: 160,
              fit: BoxFit.fill,
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(12),
                child: Text(
                  judul,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              right: 10,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(namaGuru, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),),
                  const SizedBox(width: 8), // jarak antara teks dan gambar
                  ClipOval(
                    child: Image.network(
                      '$baseImageUrl$image',
                      height: 50, // pastikan width dan height sama agar lingkaran
                      width: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 70,
                          width: 70,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey,
                          ),
                          child: const Icon(Icons.person, size: 30, color: Colors.white),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }


}