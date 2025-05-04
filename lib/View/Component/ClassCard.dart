import 'package:flutter/material.dart';

class ClassCard extends StatelessWidget{
  final String judul;
  final VoidCallback onTap;

  const ClassCard({
      super.key,
      required this.judul,
      required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
            )
          ],
        ),
      ),
    );
  }


}