import 'package:flutter/material.dart';
import 'package:sina_mobile/View/Component/CustomAppBarNoDrawer.dart';
import 'package:sina_mobile/View/Component/TitleBarLine.dart';
//import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class DetailRaportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: CustomAppBarNoDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            TitleBarLine(judul: "Rapot"),
            Card(child: Container()),
            SizedBox(height: 20),
            Text("Lampiran file"),
            SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 450,
              //child: SfPdfViewer.network('https://example.com/sample.pdf'),
              //https://drive.google.com/file/d/16XHzwmq8VnGoB-epnRGRwM-KEDQXYHfe/view?usp=drive_link
            ),
          ],
        ),
      ),
    );
  }
}
