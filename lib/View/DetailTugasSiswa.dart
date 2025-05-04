import 'package:flutter/material.dart';
import 'package:sina_mobile/View/Component/CustomAppBarNoDrawer.dart';
import 'package:sina_mobile/View/Component/CustomTextField.dart';
import 'package:sina_mobile/View/Component/RegularButton.dart';
import 'package:sina_mobile/View/Component/TitleBarLine.dart';

class DetailTugasSiswa extends StatelessWidget{
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
                        Text("I Gede Igo Wisnu Wardana"),
                        SizedBox(height: 5,),
                        Text("1293019321"),
                        SizedBox(height: 5,),
                        Text("XI.1"),
                        SizedBox(height: 5,),
                        Text("Dikmupulkan pada : 11.00 05/09/2025"),
                        SizedBox(height: 5,),
                        Text("Status : Terlambat"),
                        SizedBox(height: 5,),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text("Teks", ),
              ),
              Card(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laboru.")
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
                        Text("Tugas_igo1.pdf"),
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