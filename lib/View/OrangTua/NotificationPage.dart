import 'package:flutter/material.dart';

class Notificationpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SafeArea(
        child: Padding(padding: EdgeInsets.all(16.0), child: NotifikasiAnak()),
      ),
    );
  }
}

class NotifikasiAnak extends StatelessWidget {
  const NotifikasiAnak({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Notifikasi Anak',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              DropdownButton<String>(
                value: 'Anak 1',
                items:
                    ['Anak 1', 'Anak 2', 'Anak 3']
                        .map(
                          (value) => DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          ),
                        )
                        .toList(),
                onChanged: (newValue) {
                  // Handle dropdown value change
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildNotificationBox(),
          const SizedBox(height: 12),
          _buildNotificationBox(),
        ],
      ),
    );
  }

  Widget _buildNotificationBox() {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
