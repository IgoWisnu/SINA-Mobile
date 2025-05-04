import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sina_mobile/View/Lib/Colors.dart';

class DetailTugas extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("data", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
            SizedBox(height: 5),
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
            SizedBox(height: 20),
            Text("https//:WWW.Github.com/igowisnu", style: TextStyle(color: AppColors.blueActive),),
            SizedBox(height: 20),
            Text("File Preiview"),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Image.asset('lib/asset/image/SINA.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }

}