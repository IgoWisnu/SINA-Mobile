import 'package:flutter/material.dart';
import 'package:sina_mobile/View/Component/CustomAppBarNoDrawer.dart';

class ListRapotPage extends StatelessWidget {
  const ListRapotPage({super.key});

  @override
  Widget build(BuildContext context) {
    final rapotData = [
      {'kelas': 'X/1', 'nama': 'Stefanus Gantenk  '},
      {'kelas': 'X/2', 'nama': 'Stefanus Gantenk  '},
      {'kelas': 'XI/1', 'nama': 'Stefanus Gantenk '},
      {'kelas': 'XI/2', 'nama': 'Stefanus Gantenk '},
    ];

    return Scaffold(
      appBar: CustomAppBarNoDrawer(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          child: Column(
            children: [
              const SizedBox(height: 16),

              // Label Biru
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF2972FE),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  "Kelas/Semester",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // List Rapot
              Expanded(
                child: ListView.separated(
                  itemCount: rapotData.length,
                  separatorBuilder:
                      (context, index) => const Divider(thickness: 1),
                  itemBuilder: (context, index) {
                    final item = rapotData[index];
                    return Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            item['kelas']!,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Text(
                            item['nama']!,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_circle_right_outlined,
                            size: 20,
                          ),
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/detail-rapot',
                              arguments: {
                                'kelas': item['kelas'],
                                'nama': item['nama'],
                              },
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
