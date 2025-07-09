import 'package:flutter/material.dart';
import 'package:sina_mobile/View/Absensi.dart';
import 'package:sina_mobile/View/JadwalGuru.dart';
import 'package:sina_mobile/View/Lib/Colors.dart';
import 'package:sina_mobile/View/ListKelas.dart';
import 'package:sina_mobile/View/ListRapotSiswa.dart';
import 'package:sina_mobile/View/ListStatistikGuru.dart';
import 'package:sina_mobile/View/Pengumuman.dart';
import 'package:sina_mobile/View/ProfilGuru.dart';
import 'package:sina_mobile/View/VerifikasiSuratIzin.dart';
import 'package:sina_mobile/View/dashboard.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sina_mobile/View/loginPage.dart';

class CustomDrawer extends StatefulWidget {
  final String selectedMenu; // nama menu yang sedang aktif

  const CustomDrawer({
    super.key,
    required this.selectedMenu,
  });

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  int jumlahSuratIzinBelum = 0;

  @override
  void initState() {
    super.initState();
    _loadBadgeCount();
  }

  Future<void> _loadBadgeCount() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      jumlahSuratIzinBelum = prefs.getInt('jumlah_surat_izin_belum') ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: Stack(
        children: [
          // Background Image
          // Background Image (light or dark)
          Positioned.fill(
            child: Image.asset(
              isDarkMode
                  ? 'lib/asset/image/bg_dark2.png' // use your actual path
                  : 'lib/asset/image/bg_light2 - 1.png',
              fit: BoxFit.cover,
            ),
          ),
          // Optional dark overlay for better contrast
          Positioned.fill(
            child: Container(
              color: isDarkMode ? Colors.black.withOpacity(0.5) : Colors.white.withOpacity(0.3),
            ),
          ),

          ListView(
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
              isDarkMode: isDarkMode
            ),
            _buildMenuItem(
              context,
              icon: Icons.meeting_room_outlined,
              title: 'Kelas',
              menuKey: 'kelas',
              onClicked: () => selectedItem(context, 1),
                isDarkMode: isDarkMode
            ),
            _buildMenuItem(
              context,
              icon: Icons.group,
              title: 'Absensi',
              menuKey: 'absensi',
              onClicked: () => selectedItem(context, 2),
                isDarkMode: isDarkMode
            ),
            _buildMenuItem(
              context,
              icon: Icons.date_range_outlined,
              title: 'Jadwal Mengajar',
              menuKey: 'jadwal',
              onClicked: () => selectedItem(context, 3),
                isDarkMode: isDarkMode
            ),
            _buildMenuItem(
              context,
              icon: Icons.sticky_note_2_outlined,
              title: 'Rapot Siswa',
              menuKey: 'rapot',
              onClicked: () => selectedItem(context, 4),
                isDarkMode: isDarkMode
            ),
            _buildMenuItem(
              context,
              icon: Icons.show_chart,
              title: 'Statistik Siswa',
              menuKey: 'statistik',
              onClicked: () => selectedItem(context, 5),
                isDarkMode: isDarkMode
            ),
            _buildMenuItem(
              context,
              icon: Icons.mark_email_read_outlined,
              title: 'Verifikasi Surat Izin',
              menuKey: 'surat_izin',
              onClicked: () => selectedItem(context, 6),
              notificationCount: jumlahSuratIzinBelum,
                isDarkMode: isDarkMode
            ),
            _buildMenuItem(
              context,
              icon: Icons.info_outline,
              title: 'Pengumuman',
              menuKey: 'pengumuman',
              onClicked: () => selectedItem(context, 7),
                isDarkMode: isDarkMode
            ),
            _buildMenuItem(
              context,
              icon: Icons.person_2_outlined,
              title: 'Profil Guru',
              menuKey: 'profil_guru',
              onClicked: () => selectedItem(context, 8),
                isDarkMode: isDarkMode
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
      ]
      ),
    );
  }

  Widget _buildMenuItem(
      BuildContext context, {
        required IconData icon,
        required String title,
        required String menuKey,
        required bool isDarkMode,
        VoidCallback? onClicked,
        int? notificationCount,
      }) {
    final isSelected = widget.selectedMenu == menuKey;

    return Container(
      decoration: isSelected
          ? BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.6),
            blurRadius: 12,
            spreadRadius: 1,
            offset: Offset(0, 0),
          ),
        ],
      )
          : null,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        leading: Icon(
          icon,
          color: isSelected
              ? Colors.white
              : isDarkMode
              ? Colors.white70
              : Colors.black,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                color: isSelected
                    ? Colors.white
                    : isDarkMode
                    ? Colors.white70
                    : Colors.black,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            if (notificationCount != null && notificationCount > 0)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '$notificationCount',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
        onTap: onClicked,
      ),
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();
    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => dashboard()));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ListKelas()));
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Absensi()));
        break;
      case 3:
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => JadwalGuru()));
        break;
      case 4:
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ListRapotSiswa()));
        break;
      case 5:
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ListStatistikGuru()));
        break;
      case 6:
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => VerifikasiSuratIzin()));
        break;
      case 7:
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Pengumuman()));
        break;
      case 8:
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfilGuru()));
        break;
    }
  }
}
