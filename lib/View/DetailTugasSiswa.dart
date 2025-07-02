import 'package:flutter/material.dart';
import 'package:sina_mobile/Model/Guru/PengumpulanTugasResponse.dart';
import 'package:sina_mobile/View/Component/CustomAppBarNoDrawer.dart';
import 'package:sina_mobile/View/Component/CustomTextField.dart';
import 'package:sina_mobile/View/Component/RegularButton.dart';
import 'package:sina_mobile/View/Component/TitleBarLine.dart';
import 'package:sina_mobile/View/Lib/DateFormatter.dart';

class DetailTugasSiswa extends StatelessWidget{
  final SudahMengumpulkan tugasSiswa;

  const DetailTugasSiswa({super.key, required this.tugasSiswa});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarNoDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,),
              TitleBarLine(judul: "Detail Tugas Siswa"),
              SizedBox(height: 20),
              Card(
                child: Container(
                  alignment: Alignment.centerLeft,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(tugasSiswa.namaSiswa),
                        SizedBox(height: 5,),
                        Text(tugasSiswa.nis),
                        SizedBox(height: 5,),
                        Text("XI.1"),
                        SizedBox(height: 5,),
                        Text("Dikmupulkan pada : ${DateFormatter.format(tugasSiswa.tanggalPengumpulan)}"),
                        SizedBox(height: 5,),
                        Text("Status : ${tugasSiswa.statusPengumpulan}"),
                        SizedBox(height: 5,),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text("Uraian", ),
              ),
              Card(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Text(tugasSiswa.uraian)
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text("File", ),
              ),
              Card(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(tugasSiswa.fileJawaban),
                        SizedBox(height: 5,),
                        Image.asset("lib/asset/image/SINA.png")
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text("Nilai", ),
              ),
              CustomTextField(controller: TextEditingController(), hintText: "Masukan Nilai",),
              SizedBox(height: 50,),
              RegularButton(onTap: (){}, judul: "Tandai sebagai selesai"),
              SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }

}