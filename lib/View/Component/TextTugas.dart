import 'package:flutter/material.dart';

class TextTugas extends StatelessWidget{

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
            Row(
              children: [
                Text("data"),
                Icon(Icons.mode_edit)
              ],
            ),
            Text("data"),
            Row(
              children: [
                Icon(Icons.file_copy),
                Text("data")
              ],
            ),
            Row(
              children: [
                Icon(Icons.link),
                Text("data")
              ],
            )
          ],
        ),
      ),
    );
  }

}