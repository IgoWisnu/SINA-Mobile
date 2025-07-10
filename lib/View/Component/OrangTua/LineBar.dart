import 'package:flutter/material.dart';

class LineBar extends StatelessWidget {
  const LineBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,

      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black, // Set your desired color
            width: 4.0, // Set your desired width
          ),
        ),
      ),
    );
  }
}
