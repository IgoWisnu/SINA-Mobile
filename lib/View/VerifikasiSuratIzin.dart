import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sina_mobile/View/Component/CustomAppBar.dart';
import 'package:sina_mobile/View/Component/Custom_drawer.dart';
import 'package:sina_mobile/View/Component/ItemDaftarIzin.dart';
import 'package:sina_mobile/View/Lib/Colors.dart';
import 'package:sina_mobile/View/VerifikasiSuratIzinDetail.dart';
import '../Model/Guru/SuratIzinModel.dart';
import '../ViewModel/Guru/SuratIzinViewModel.dart';

class VerifikasiSuratIzin extends StatefulWidget {
  @override
  _VerifikasiSuratIzinState createState() => _VerifikasiSuratIzinState();
}

class _VerifikasiSuratIzinState extends State<VerifikasiSuratIzin> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final String currentMenu = 'surat_izin';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = Provider.of<SuratIzinViewModel>(context, listen: false);
      if (viewModel.suratIzinList.isEmpty) {
        viewModel.fetchSuratIzin();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(selectedMenu: currentMenu),
      appBar: CustomAppBar(
        onMenuPressed: () => _scaffoldKey.currentState?.openDrawer(),
      ),
      body: Consumer<SuratIzinViewModel>(
        builder: (context, viewModel, _) {
          return _buildBodyContent(viewModel);
        },
      ),
    );
  }

  Widget _buildBodyContent(SuratIzinViewModel viewModel) {
    if (viewModel.isLoading && viewModel.suratIzinList.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }

    if (viewModel.errorMessage.isNotEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(viewModel.errorMessage),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => viewModel.fetchSuratIzin(),
              child: Text('Coba Lagi'),
            ),
          ],
        ),
      );
    }

    if (viewModel.suratIzinList.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Tidak ada surat izin yang perlu diverifikasi'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => viewModel.fetchSuratIzin(),
              child: Text('Refresh'),
            ),
          ],
        ),
      );
    }

    // Pisahkan data berdasarkan status
    final belumList = viewModel.suratIzinList.where((s) => s.statusSurat == 'menunggu').toList();
    final terimaList = viewModel.suratIzinList.where((s) => s.statusSurat == 'terima').toList();

    return RefreshIndicator(
      onRefresh: () => viewModel.fetchSuratIzin(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(title: "Belum Diverifikasi"),
            ...belumList.map(
                  (surat) => ItemDaftarIzin(
                nama: surat.namaSiswa,
                kelas: surat.keterangan,
                tanggal: surat.formattedDate,
                status: surat.statusSurat,
                ontap: () => _navigateToDetail(context, surat),
              ),
            ),

            SizedBox(height: 30),

            _buildHeader(title: "Sudah Diverifikasi"),
            ...terimaList.map(
                  (surat) => ItemDaftarIzin(
                nama: surat.namaSiswa,
                kelas: surat.keterangan,
                tanggal: surat.formattedDate,
                status: surat.statusSurat,
                ontap: () => _navigateToDetail(context, surat),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader({required String title}) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToDetail(BuildContext context, SuratIzinModel surat) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VerifikasiSuratIzinDetail(surat: surat),
      ),
    );

    final viewModel = Provider.of<SuratIzinViewModel>(context, listen: false);
    await viewModel.fetchSuratIzin();

    // Tambahkan ini untuk trigger pembaruan drawer
    final prefs = await SharedPreferences.getInstance();
    final count = prefs.getInt('jumlah_surat_izin_belum') ?? 0;
    print("Updated count: $count");
  }
}
