import 'package:flutter/material.dart';
import 'package:sina_mobile/Model/Guru/TugasGuru.dart';
import 'package:sina_mobile/View/Component/AddButton.dart';
import 'package:sina_mobile/View/Component/CustomAppBarNoDrawer.dart';
import 'package:sina_mobile/View/Component/DetailTugas.dart';
import 'package:sina_mobile/View/Component/ItemTugasSiswa.dart';
import 'package:sina_mobile/View/Component/StatusTugas.dart';
import 'package:sina_mobile/View/Component/TitleBarLine.dart';
import 'package:sina_mobile/View/DetailTugasSiswa.dart';
import 'package:sina_mobile/ViewModel/Guru/TugasDetailGuruViewModel.dart';
import 'package:provider/provider.dart';

class TugasDetail extends StatefulWidget{
  final TugasItem tugas;
  final String mapelId;

  const TugasDetail({super.key, required this.tugas, required this.mapelId});


  @override
  State<TugasDetail> createState() => _TugasDetailState();
}


class _TugasDetailState extends State<TugasDetail> {

  @override
  void initState() {
    super.initState();
    // Ambil data kelas saat widget dibuka
    Future.microtask(() =>
        Provider.of<TugasDetailGuruViewModel>(context, listen: false).fetchSiswaMengumpulkan(idMapel: widget.mapelId, idTugas: widget.tugas.tugasId));
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<TugasDetailGuruViewModel>(context);

    return Scaffold(
      appBar: CustomAppBarNoDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              StatusTugas(
                judul: widget.tugas.judul,
                uploadDate: widget.tugas.createdAt,
                tenggat: widget.tugas.tenggatKumpul,
                sudahDikumpul: widget.tugas.jumlahDikumpulkan.toString(),
                belumDikumpul: widget.tugas.jumlahSiswa.toString(),
                terlambat: widget.tugas.jumlahTerlambat.toString(),
              ),
              SizedBox(height: 20,),
              DetailTugas(
                judul: widget.tugas.judul,
                keterangan: widget.tugas.deskripsi,
              ),
              SizedBox(height: 20,),
              TitleBarLine(judul: "Dikumpulkan"),
              vm.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : vm.error != null
                  ? Center(child: Text('Error: ${vm.error}'))
                  : ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: vm.kelasList.length,
                itemBuilder: (context, index) {
                  final itemTugas = vm.kelasList[index];
                  return ItemTugasSiswa(
                    nama: itemTugas.namaSiswa,
                    ontap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailTugasSiswa(
                            tugasSiswa : itemTugas
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              SizedBox(height: 20,)
            ],
          ),
        ),

      ),
    );
  }
}