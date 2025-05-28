import 'package:flutter/material.dart';
import 'package:sina_mobile/View/Component/CustomAppBarNoDrawer.dart';
import 'package:sina_mobile/View/Component/RegularButton.dart';
import 'package:sina_mobile/View/Lib/Colors.dart';

class VerifikasiSuratIzinDetail extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: CustomAppBarNoDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(5)
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text("Detail Surat Izin", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),),
                ),
                alignment: Alignment.centerLeft,
              ),
              Container(
                width: double.infinity,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          child: Text("Nama Siswa", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                          width: 150,
                        ),
                        SizedBox(width: 100,),
                        Text("Igo Wisnu")
                      ],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            child: Text("Tanggal Izin", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                          width: 150,

                        ),
                        SizedBox(width: 100,),
                        Text("20/05/2025")
                      ],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            child: Text("Jenis Izin", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                          width: 150,
                        ),
                        SizedBox(width: 100,),
                        Text("Sakit")
                      ],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            child: Text("Keterangan", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                          width: 150,
                        ),
                        SizedBox(width: 100,),
                        Expanded(
                            child: Text("Selamat Pagi Bapak/Ibu guru yang mengajar , Mohon maaf I WayanIdo tidak dapat hadir hari ini dikarenakan sedang sakit")
                        )
                      ],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            child: Text("Surat", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                          width: 150,
                        ),
                        SizedBox(width: 100,),
                        Text("Surat_izin.pdf")
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: RegularButton(
            onTap: (){
              Navigator.pop(context);
            },
            judul: "Setujui"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

}