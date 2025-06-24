import 'package:flutter/material.dart';
import 'package:sina_mobile/Model/Guru/AbsensiInput.dart';

class ItemAbsensi extends StatefulWidget {
  final AbsensiInput input;

  const ItemAbsensi({super.key, required this.input});

  @override
  State<ItemAbsensi> createState() => _ItemAbsensiState();
}

class _ItemAbsensiState extends State<ItemAbsensi> {
  String _selectedStatus = 'H'; // atau nilai default lainnya

  @override
  void initState() {
    super.initState();
    _selectedStatus = widget.input.status;
  }

  void _onStatusChanged(String? value) {
    if (value != null) {
      setState(() {
        _selectedStatus = value;
        widget.input.status = value; // Sinkronkan dengan model
      });
    }
  }

  Widget _buildRadio(String value, String label) {
    return Row(
      children: [
        Radio<String>(
          value: value,
          groupValue: _selectedStatus, // Reaktif
          onChanged: _onStatusChanged,
        ),
        Text(label),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.input.nama),
            Row(
              children: [
                _buildRadio('H', ''),
                _buildRadio('S', ''),
                _buildRadio('I', ''),
                _buildRadio('A', ''),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
