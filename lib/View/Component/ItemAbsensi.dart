import 'package:flutter/material.dart';

class ItemAbsensi extends StatefulWidget{

  @override
  State<ItemAbsensi> createState() => _ItemAbsensiState();
}

class _ItemAbsensiState extends State<ItemAbsensi> {
  String? _selectedStatus; // Menyimpan status yang dipilih

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("data"),
            Row(
              children: [
                Radio<String>(
                  value: 'H',
                  groupValue: _selectedStatus,
                  onChanged: (value) {
                    setState(() {
                      _selectedStatus = value;
                    });
                  },
                ),
                Radio<String>(
                  value: 'I',
                  groupValue: _selectedStatus,
                  onChanged: (value) {
                    setState(() {
                      _selectedStatus = value;
                    });
                  },
                ),
                Radio<String>(
                  value: 'S',
                  groupValue: _selectedStatus,
                  onChanged: (value) {
                    setState(() {
                      _selectedStatus = value;
                    });
                  },
                ),
                Radio<String>(
                  value: 'A',
                  groupValue: _selectedStatus,
                  onChanged: (value) {
                    setState(() {
                      _selectedStatus = value;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}