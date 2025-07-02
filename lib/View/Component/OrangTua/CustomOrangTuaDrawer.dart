import 'package:flutter/material.dart';
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
import 'package:shared_preferences/shared_preferences.dart';

class CustomOrangTuaDrawer extends StatelessWidget {
  final String selectedMenu;

  const CustomOrangTuaDrawer({super.key, required this.selectedMenu});

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
            menuKey: 'dashboardortu',

            onClicked: () => selectedItem(context, 0),
          ),
          _buildMenuItem(
            context,
            icon: Icons.meeting_room_outlined,
            title: 'Statistik Nilai',
            menuKey: 'statistik',

            onClicked: () => selectedItem(context, 1),
          ),
          _buildMenuItem(
            context,
            icon: Icons.date_range_outlined,
            title: 'Jadwal Pelajaran',
            menuKey: 'jadwal_pelajaran',

            onClicked: () => selectedItem(context, 2),
          ),
          _buildMenuItem(
            context,
            icon: Icons.sticky_note_2_outlined,
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
            icon: Icons.message_outlined,
            title: 'Pengajuan Surat Ijin',
            menuKey: 'formpengajuan',

            onClicked: () => selectedItem(context, 5),
          ),
          _buildMenuItem(
            context,
            icon: Icons.info_outline,
            title: 'Pengumuman',
            menuKey: 'pengumumanOrtu',

            onClicked: () => selectedItem(context, 6),
          ),
          _buildMenuItem(
            context,
            icon: Icons.person_outline,
            title: 'Profil OrangTua',
            menuKey: 'profil_ortu',

            onClicked: () => selectedItem(context, 7),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Logout', style: TextStyle(color: Colors.red)),
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
                        child: const Text(
                          'Logout',
                          style: TextStyle(color: Colors.red),
                        ),
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
    VoidCallback? onClicked,
  }) {
    final isSelected = selectedMenu == menuKey;

    return ListTile(
      selected: isSelected,
      selectedTileColor: Colors.blue,
      leading: Icon(icon, color: isSelected ? Colors.white : Colors.black),
      title: Text(
        title,
        style: TextStyle(color: isSelected ? Colors.white : Colors.black),
      ),
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop(); // Tutup drawer

    switch (index) {
      case 0:
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (context) => Dashboardorangtua()));
        break;
      case 1:
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (context) => StatistikOrtuPage()));
        break;
      case 2:
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (context) => JadwalPelajaranPage()));
        break;
      case 3:
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (context) => ListRapotPage()));
        break;
      case 4:
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (context) => RekapAbsensiOrtuPage()));
        break;
      case 5:
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (context) => RiwayatPengajuanPage()));
        break;
      case 6:
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (context) => PengumumanOrtu()));
        break;
      case 7:
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (context) => ProfilOrangTuaPage()));
        break;
    }
  }
}
