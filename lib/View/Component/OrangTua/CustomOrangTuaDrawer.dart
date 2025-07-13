import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sina_mobile/View/OrangTua/DashboardOrangTua.dart';
import 'package:sina_mobile/View/OrangTua/FormPengajuanPage.dart';
import 'package:sina_mobile/View/OrangTua/JadwalPelajaranPage.dart';
import 'package:sina_mobile/View/OrangTua/ListRaportPage.dart';
import 'package:sina_mobile/View/OrangTua/PengumumanOrtu.dart';
import 'package:sina_mobile/View/OrangTua/ProfilOrangTuaPage.dart';
import 'package:sina_mobile/View/OrangTua/RekapAbsensiOrtuPage.dart';
import 'package:sina_mobile/View/OrangTua/RiwayatPengajuanPage.dart';
import 'package:sina_mobile/View/OrangTua/StatistikOrtuPage.dart';
import 'package:sina_mobile/View/loginPage.dart';

class CustomOrangTuaDrawer extends StatelessWidget {
  final String selectedMenu;

  const CustomOrangTuaDrawer({super.key, required this.selectedMenu});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 8,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Container(
        color: Colors.white,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          children: [
            const SizedBox(height: 30),

            // Logo
            Center(
              child: Image.asset(
                'lib/asset/image/SINA v2.png',
                width: 100,
                height: 100,
              ),
            ),
            const SizedBox(height: 16),
            const Divider(thickness: 1),

            // Menu Items
            _buildMenuItem(
              context,
              icon: Icons.space_dashboard_outlined,
              title: 'Dashboard',
              menuKey: 'dashboardortu',
              onClicked: () => selectedItem(context, 0),
            ),
            _buildMenuItem(
              context,
              icon: Icons.bar_chart_outlined,
              title: 'Statistik Nilai',
              menuKey: 'statistik',
              onClicked: () => selectedItem(context, 1),
            ),
            _buildMenuItem(
              context,
              icon: Icons.schedule_outlined,
              title: 'Jadwal Pelajaran',
              menuKey: 'jadwal_pelajaran',
              onClicked: () => selectedItem(context, 2),
            ),
            _buildMenuItem(
              context,
              icon: Icons.book_outlined,
              title: 'Rapot Siswa',
              menuKey: 'list_rapot',
              onClicked: () => selectedItem(context, 3),
            ),
            _buildMenuItem(
              context,
              icon: Icons.people_alt_outlined,
              title: 'Rekap Absensi',
              menuKey: 'rekap_absensi',
              onClicked: () => selectedItem(context, 4),
            ),
            _buildMenuItem(
              context,
              icon: Icons.note_alt_outlined,
              title: 'Pengajuan Izin',
              menuKey: 'formpengajuan',
              onClicked: () => selectedItem(context, 5),
            ),
            _buildMenuItem(
              context,
              icon: Icons.announcement_outlined,
              title: 'Pengumuman',
              menuKey: 'pengumumanOrtu',
              onClicked: () => selectedItem(context, 6),
            ),
            _buildMenuItem(
              context,
              icon: Icons.person_outline,
              title: 'Profil Orang Tua',
              menuKey: 'profil_ortu',
              onClicked: () => selectedItem(context, 7),
            ),

            const Divider(thickness: 1, height: 32),

            // Logout
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Logout', style: TextStyle(color: Colors.red)),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      title: const Text('Konfirmasi Logout'),
                      content: const Text('Apakah Anda yakin ingin logout?'),
                      actions: [
                        TextButton(
                          child: const Text('Batal'),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        TextButton(
                          child: const Text(
                            'Logout',
                            style: TextStyle(color: Colors.red),
                          ),
                          onPressed: () async {
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.clear();
                            Navigator.of(context).pop();
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (_) => LoginPage()),
                              (route) => false,
                            );
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String menuKey,
    VoidCallback? onClicked,
  }) {
    final isSelected = selectedMenu == menuKey;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: isSelected ? Colors.white : Colors.black87),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
        onTap: onClicked,
      ),
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (_) => Dashboardorangtua()));
        break;
      case 1:
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (_) => StatistikOrtuPage()));
        break;
      case 2:
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (_) => JadwalPelajaranPage()));
        break;
      case 3:
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (_) => ListRapotPage()));
        break;
      case 4:
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (_) => RekapAbsensiOrtuPage()));
        break;
      case 5:
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (_) => RiwayatPengajuanPage()));
        break;
      case 6:
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (_) => PengumumanOrtu()));
        break;
      case 7:
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (_) => ProfilOrangTuaPage()));
        break;
    }
  }
}
