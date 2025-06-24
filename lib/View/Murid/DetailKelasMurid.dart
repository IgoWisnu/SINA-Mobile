import 'package:flutter/material.dart';
import 'package:sina_mobile/Model/Materi.dart';
import 'package:sina_mobile/Model/Tugas.dart';
import 'package:sina_mobile/View/Component/AddButton.dart';
import 'package:sina_mobile/View/Component/ClassCard.dart';
import 'package:sina_mobile/View/Component/CustomAppBarNoDrawer.dart';
import 'package:sina_mobile/View/Component/ItemTugas.dart';
import 'package:sina_mobile/View/Component/Murid/ItemMateriMurid.dart';
import 'package:sina_mobile/View/Component/Murid/ItemTugasMurid.dart';
import 'package:sina_mobile/View/Component/TitleBarLine.dart';
import 'package:sina_mobile/View/DetailTugasSiswa.dart';
import 'package:sina_mobile/View/Murid/DetailMateriMurid.dart';
import 'package:sina_mobile/View/Murid/DetailTugasMurid.dart';
import 'package:sina_mobile/View/TambahTugas.dart';
import 'package:provider/provider.dart';
import 'package:sina_mobile/ViewModel/KelasDetailViewModel.dart';
import 'package:sina_mobile/ViewModel/KelasViewModel.dart';
import 'package:sina_mobile/Model/JenisItem.dart';

class DetailKelasMurid extends StatefulWidget {
  final String mapelId;
  final String mapelJudul;

  const DetailKelasMurid({super.key, required this.mapelId, required this.mapelJudul});

  @override
  State<DetailKelasMurid> createState() => _DetailKelasMuridState();
}

class _DetailKelasMuridState extends State<DetailKelasMurid> {
  @override
  void initState() {
    super.initState();
    // Ambil data kelas saat widget dibuka
    Future.microtask(() {
      final vm = Provider.of<KelasDetailViewModel>(context, listen: false);
      vm.fetchTugasMateri(widget.mapelId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<KelasDetailViewModel>(context);

    return Scaffold(
      appBar: CustomAppBarNoDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClassCard(judul: widget.mapelJudul, onTap: () {}),
            const SizedBox(height: 20),
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
                      final tugas = item.data as Tugas;
                      return ItemTugasMurid(
                        onTap: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailTugasMurid(tugas: tugas),
                            ),
                          );
                          if (result == true) {
                            // Data di halaman DetailTugasMurid diubah, maka refresh ulang
                            final vm = Provider.of<KelasDetailViewModel>(context, listen: false);
                            vm.fetchTugasMateri(widget.mapelId);
                          }
                        },
                        judul: tugas.namaTugas,
                        upload_date: tugas.createAt ?? DateTime.now(),
                        tenggat: tugas.tenggatKumpul ?? DateTime.now(),
                        status: tugas.status,
                      );

                    case JenisItem.materi:
                      final materi = item.data as Materi;
                      return ItemMateriMurid(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailMateriMurid(materi: materi),
                            ),
                          );
                        },
                        judul: materi.namaMateri,
                        upload_date: materi.tanggalPengumpulan,
                      );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
