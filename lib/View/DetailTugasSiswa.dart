import 'package:flutter/material.dart';
import 'package:sina_mobile/Model/Guru/PengumpulanTugasResponse.dart';
import 'package:sina_mobile/View/Component/CustomAppBarNoDrawer.dart';
import 'package:sina_mobile/View/Component/CustomSnackbar.dart';
import 'package:sina_mobile/View/Component/CustomTextField.dart';
import 'package:sina_mobile/View/Component/RegularButton.dart';
import 'package:sina_mobile/View/Component/TitleBarLine.dart';
import 'package:sina_mobile/View/Lib/DateFormatter.dart';
import 'package:sina_mobile/ViewModel/Guru/DetailTugasSiswaVIewModel.dart';
import 'package:provider/provider.dart';

class DetailTugasSiswa extends StatefulWidget{
  final SudahMengumpulkan tugasSiswa;
  final String idMapel;
  final String idTugas;
  final String krsId;

  const DetailTugasSiswa({super.key, required this.tugasSiswa, required this.idMapel, required this.idTugas, required this.krsId});

  @override
  State<DetailTugasSiswa> createState() => _DetailTugasSiswaState();
}

class _DetailTugasSiswaState extends State<DetailTugasSiswa> {
  final TextEditingController _nilaiController = TextEditingController();
  bool _isLoading = false;

  Future<void> _updateNilai() async {
    final vm = Provider.of<DetailTugasSiswaViewModel>(context, listen: false);

    // Validasi minimal (opsional, tambahkan validasi lain jika diperlukan)
    if (_nilaiController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Mohon isi nilai terlebih dahulu.")),
      );
      return;
    }

    try {
      await vm.updateProfilGuru(widget.idMapel, widget.idTugas, widget.krsId, _nilaiController.text);
      CustomSnackbar.showSuccess(context, "Berhasil Menilai Tugas");
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal Menilai Tugas: $e")),
      );
    }
  }

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
                        Text(widget.tugasSiswa.namaSiswa),
                        SizedBox(height: 5,),
                        Text(widget.tugasSiswa.nis),
                        SizedBox(height: 5,),
                        Text("XI.1"),
                        SizedBox(height: 5,),
                        Text("Dikmupulkan pada : ${DateFormatter.format(widget.tugasSiswa.tanggalPengumpulan)}"),
                        SizedBox(height: 5,),
                        Text("Status : ${widget.tugasSiswa.statusPengumpulan}"),
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
                        Text(widget.tugasSiswa.uraian)
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
                        Text(widget.tugasSiswa.fileJawaban),
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
              CustomTextField(controller: _nilaiController, hintText: "Masukan Nilai",),
              SizedBox(height: 50,),
              RegularButton(onTap: _updateNilai, judul: "Tandai sebagai selesai"),
              SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}