import 'package:flutter/material.dart';
import 'package:sina_mobile/View/Absensi.dart';
import 'package:sina_mobile/View/JadwalGuru.dart';
import 'package:sina_mobile/View/ListKelas.dart';
import 'package:sina_mobile/View/ListRapotSiswa.dart';
import 'package:sina_mobile/View/Murid/DashboardMurid.dart';
import 'package:sina_mobile/View/Murid/JadwalPelajaranMurid.dart';
import 'package:sina_mobile/View/Murid/ListKelasMurid.dart';
import 'package:sina_mobile/View/Murid/PengumumanMurid.dart';
import 'package:sina_mobile/View/Murid/ProfilMurid.dart';
import 'package:sina_mobile/View/Murid/RapotMurid.dart';
import 'package:sina_mobile/View/Murid/RekapAbsensiMurid.dart';
import 'package:sina_mobile/View/Murid/StatistikSiswa.dart';
import 'package:sina_mobile/View/Pengumuman.dart';
import 'package:sina_mobile/View/dashboard.dart';
import 'package:sina_mobile/View/loginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomMuridDrawer extends StatelessWidget {
  final String selectedMenu; // nama menu yang sedang aktif

  const CustomMuridDrawer({
    super.key,
    required this.selectedMenu,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const SizedBox(height: 50),
          ListTile(
            leading: Image.asset(
              'lib/asset/image/SINA v2.png',
              width: 80,
              height: 80,
            ),
            onTap: () {},
          ),
          _buildMenuItem(
            context,
            icon: Icons.space_dashboard_outlined,
            title: 'Dashboard',
            menuKey: 'dashboard',
            onClicked: () => selectedItem(context, 0),
          ),
          _buildMenuItem(
            context,
            icon: Icons.meeting_room_outlined,
            title: 'Kelas',
            menuKey: 'kelas',
            onClicked: () => selectedItem(context, 1),
          ),
          _buildMenuItem(
            context,
            icon: Icons.date_range_outlined,
            title: 'Jadwal Pelajaran',
            menuKey: 'jadwal',
            onClicked: () => selectedItem(context, 2),
          ),
          _buildMenuItem(
            context,
            icon: Icons.sticky_note_2,
            title: 'Rapot Siswa',
            menuKey: 'rapot',
            onClicked: () => selectedItem(context, 3),
          ),
          _buildMenuItem(
            context,
            icon: Icons.people_alt_outlined,
            title: 'Rekap Absensi',
            menuKey: 'rekap',
            onClicked: () => selectedItem(context, 4),
          ),
          _buildMenuItem(
            context,
            icon: Icons.show_chart,
            title: 'Statistik Siswa',
            menuKey: 'statistik',
            onClicked: () => selectedItem(context, 5),
          ),
          _buildMenuItem(
            context,
            icon: Icons.info_outline,
            title: 'Pengumuman',
            menuKey: 'pengumuman',
            onClicked: () => selectedItem(context, 6),
          ),
          _buildMenuItem(
            context,
            icon: Icons.person_2_outlined,
            title: 'Profil murid',
            menuKey: 'profil',
            onClicked: () => selectedItem(context, 7),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text(
              'Logout',
              style: TextStyle(color: Colors.red),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Konfirmasi Logout'),
                    content: const Text('Apakah Anda yakin ingin logout?'),
                    actions: [
                      TextButton(
                        child: const Text('Batal'),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      TextButton(
                        child: const Text('Logout', style: TextStyle(color: Colors.red)),
                        onPressed: () async {
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.clear();

                          Navigator.of(context).pop(); // Tutup dialog
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
    );
  }

  Widget _buildMenuItem(
      BuildContext context, {
        required IconData icon,
        required String title,
        required String menuKey,
        VoidCallback? onClicked
      }) {
    final isSelected = selectedMenu == menuKey;

    return ListTile(
      selected: isSelected,
      selectedTileColor: Colors.blue, // latar biru saat aktif
      leading: Icon(
        icon,
        color: isSelected ? Colors.white : Colors.black, // icon putih saat aktif
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
        ),
      ),
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DashboardMurid(),
        ));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ListKelasMurid(),
        ));
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => JadwalPelajaranMurid(),
        ));
        break;
      case 3:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => RapotMurid(),
        ));
        break;
      case 4:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => RekapAbsensiMurid(),
        ));
        break;
      case 5:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => StatistikSiswa(),
        ));
        break;
      case 6:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => PengumumanMurid(),
        ));
        break;
      case 7:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ProfilMurid(),
        ));
        break;
    }
  }
}
