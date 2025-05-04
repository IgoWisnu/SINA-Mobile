import 'package:flutter/material.dart';

import 'SmallTextField.dart';

class ItemNilaiRapot extends StatelessWidget{
  final TextEditingController controller;
  final String mata_pelajaran;
  final String no;

  const ItemNilaiRapot({super.key, required this.controller, required this.mata_pelajaran, required this.no});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border(
          bottom: BorderSide(
          color: Colors.black, // Set your desired color
          width: 2.0,)
      )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(no),
            Text(mata_pelajaran),
            SmallTextField()
          ],
        ),
      ),
    );
  }

}