import 'package:flutter/material.dart';
import 'package:sina_mobile/View/Component/CustomAppBarNoDrawer.dart';

class PengumumanDetailMurid extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: CustomAppBarNoDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(

          ),
        ),
      ),
    );
  }

}