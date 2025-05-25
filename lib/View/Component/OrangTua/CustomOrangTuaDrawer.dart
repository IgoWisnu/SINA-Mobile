import 'package:flutter/material.dart';

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
            menuKey: 'dashboard',
            routeName: '/dashboard',
          ),
          _buildMenuItem(
            context,
            icon: Icons.meeting_room_outlined,
            title: 'Statistik Nilai',
            menuKey: 'statistik',
            routeName: '/statistik',
          ),
          _buildMenuItem(
            context,
            icon: Icons.date_range_outlined,
            title: 'Jadwal Pelajaran',
            menuKey: 'jadwal',
            routeName: '/jadwal',
          ),
          _buildMenuItem(
            context,
            icon: Icons.sticky_note_2_outlined,
            title: 'Rapot Siswa',
            menuKey: 'rapot',
            routeName: '/list-rapot',
          ),
          _buildMenuItem(
            context,
            icon: Icons.people_alt_outlined,
            title: 'Rekap Absensi',
            menuKey: 'rekap',
            routeName: '/rekap',
          ),
          _buildMenuItem(
            context,
            icon: Icons.message_outlined,
            title: 'Pengajuan Surat Ijin',
            menuKey: 'pengajuan',
            routeName: '/pengajuan',
          ),
          _buildMenuItem(
            context,
            icon: Icons.info_outline,
            title: 'Pengumuman',
            menuKey: 'pengumuman',
            routeName: '/pengumuman',
          ),
          _buildMenuItem(
            context,
            icon: Icons.person_outline,
            title: 'Profil OrangTua',
            menuKey: 'profil',
            routeName: '/profil',
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
    required String routeName,
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
      onTap: () {
        Navigator.pop(context); // tutup drawer dulu
        if (ModalRoute.of(context)?.settings.name != routeName) {
          Navigator.pushNamed(context, routeName);
        }
      },
    );
  }
}
