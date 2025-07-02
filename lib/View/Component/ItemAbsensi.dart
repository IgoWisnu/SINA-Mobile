import 'package:flutter/material.dart';

class ItemAbsensi extends StatefulWidget {
  @override
  State<ItemAbsensi> createState() => _ItemAbsensiState();
}

class _ItemAbsensiState extends State<ItemAbsensi> {
  String? _selectedStatus;

  @override
  void initState() {
    super.initState();
    _selectedStatus = 'H'; // Set default value
  }

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
                _buildRadio('H', ''),
                _buildRadio('I', ''),
                _buildRadio('S', ''),
                _buildRadio('A', ''),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRadio(String value, String label) {
    return Row(
      children: [
        Radio<String>(
          value: value,
          groupValue: _selectedStatus,
          onChanged: (value) {
            setState(() {
              _selectedStatus = value;
            });
          },
        ),
        Text(label),
      ],
    );
  }
}
