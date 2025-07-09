import 'package:flutter/material.dart';
import 'package:sina_mobile/Model/Guru/MateriGuru.dart';
import 'package:sina_mobile/Model/Guru/TugasGuru.dart';
import 'package:sina_mobile/Model/Materi.dart';
import 'package:sina_mobile/Model/Tugas.dart';
import 'package:sina_mobile/View/Component/AddButton.dart';
import 'package:sina_mobile/View/Component/ClassCard.dart';
import 'package:sina_mobile/View/Component/CustomAppBarNoDrawer.dart';
import 'package:sina_mobile/View/Component/ItemMateriGuru.dart';
import 'package:sina_mobile/View/Component/ItemTugas.dart';
import 'package:sina_mobile/View/Component/Murid/ItemMateriMurid.dart';
import 'package:sina_mobile/View/Component/Murid/ItemTugasMurid.dart';
import 'package:sina_mobile/View/Component/RegularButton.dart';
import 'package:sina_mobile/View/Component/StatusTugas.dart';
import 'package:sina_mobile/View/Component/TitleBarLine.dart';
import 'package:sina_mobile/View/Lib/Colors.dart';
import 'package:sina_mobile/View/MateriDetailGuru.dart';
import 'package:sina_mobile/View/TambahMateri.dart';
import 'package:sina_mobile/View/TambahTugas.dart';
import 'package:provider/provider.dart';
import 'package:sina_mobile/View/TugasDetailView.dart';
import 'package:sina_mobile/ViewModel/Guru/KelasDetailGuruViewModel.dart';
import 'package:sina_mobile/Model/JenisItem.dart';

class KelasDetail extends StatefulWidget{
  final String mapelId;
  final String mapelJudul;

  const KelasDetail({super.key, required this.mapelId, required this.mapelJudul});

  @override
  State<KelasDetail> createState() => _KelasDetailState();
}

class _KelasDetailState extends State<KelasDetail> {

  @override
  void initState() {
    super.initState();
    // Ambil data kelas saat widget dibuka
    Future.microtask(() {
      final vm = Provider.of<KelasDetailGuruViewModel>(context, listen: false);
      vm.fetchTugasMateri(widget.mapelId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<KelasDetailGuruViewModel>(context);

    void showAddOptionsDialog(BuildContext context) {
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Tambah Tugas / Materi',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 20),
                  RegularButton(
                    judul: 'Tugas',
                    onTap: () async {
                      Navigator.pop(context); // Tutup dialog
                      await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TambahTugas(idMapel: widget.mapelId)),
                      );
                      vm.fetchTugasMateri(widget.mapelId); // Refresh data
                    },
                  ),
                  const SizedBox(height: 10),
                  RegularButton(
                    judul: 'Materi',
                    onTap: () async {
                      Navigator.pop(context); // Tutup dialog
                      await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TambahMateri(idMapel: widget.mapelId)),
                      );
                      vm.fetchTugasMateri(widget.mapelId); // Refresh data
                    },
                  ),

                ],
              ),
            ),
          );
        },
      );
    }


    // TODO: implement build
    return Scaffold(
      appBar: CustomAppBarNoDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                gradient: AppColors.blueToBlueGradient,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.6),
                    blurRadius: 12,
                    spreadRadius: 1,
                    offset: Offset(0, 0),
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top row
                    Row(
                      children: [
                        Icon(Icons.library_books, color: Colors.white, size: 50),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            widget.mapelJudul,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const Spacer(),

                    // Bottom Row with text + avatar stack
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Text
                          Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: Text(
                              '1 Siswa Di Kelas',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),

                          // Avatar stack
                          SizedBox(
                            height: 50,
                            width: 120,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 0,
                                  child: CircleAvatar(
                                    radius: 25,
                                    backgroundImage: AssetImage('lib/asset/image/male_avatar.png'),
                                  ),
                                ),
                                Positioned(
                                  left: 30,
                                  child: CircleAvatar(
                                    radius: 25,
                                    backgroundImage: AssetImage('lib/asset/image/female_vector.png'),
                                  ),
                                ),
                                Positioned(
                                  left: 60,
                                  child: CircleAvatar(
                                    radius: 25,
                                    backgroundImage: AssetImage('lib/asset/image/female2_vector.png'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20,),
            vm.isLoading
                ? const Center(child: CircularProgressIndicator())
                : vm.error != null
                ? Center(child: Text('Error: ${vm.error}'))
                : Expanded(
              child: ListView.builder(
                itemCount: vm.daftarGabungan.length,
                itemBuilder: (context, index) {
                  final item = vm.daftarGabungan[index];
                  switch (item.jenis) {
                    case JenisItem.tugas:
                      final tugas = item.data as TugasItem;
                      return ItemTugas(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TugasDetailView(tugas: tugas, mapelId: widget.mapelId,),
                            ),
                          );
                        },
                        judul: tugas.judul,
                        upload_date: tugas.createdAt,
                        dikumpul: tugas.jumlahDikumpulkan,
                        jumlahsiswa: tugas.jumlahSiswa,
                        tenggat: tugas.tenggatKumpul,
                      );

                    case JenisItem.materi:
                      final materi = item.data as MateriItem;
                      return ItemMateriMurid(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MateriDetailGuru(
                                judul: materi.namaMateri,
                                deskripsi: materi.uraian,
                                lampiran: materi.lampiran,
                              ),
                            ),
                          );
                          vm.fetchTugasMateri(widget.mapelId);
                        },
                        judul: materi.namaMateri,
                        upload_date: materi.createdAt,
                      );
                  }
                },
              ),
            )
          ],
        ),
      ),
        floatingActionButton: AddButton(
          onPressed: () {
            showAddOptionsDialog(context);
          },
        ),
    floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}