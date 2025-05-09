import 'package:flutter/material.dart';

import '../RegularButton.dart';

class TugasMuridTerkumpul extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Kumpulkan Tugas"),
        RegularButton(onTap: (){}, judul: "Edit tugas")
      ],
    );
  }

}