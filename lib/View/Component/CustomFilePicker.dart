import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class CustomFilePicker extends StatelessWidget {
  final String label;
  final Function(String) onFilePicked;

  const CustomFilePicker({
    Key? key,
    required this.label,
    required this.onFilePicked,
  }) : super(key: key);

  Future<void> _pickFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.single.path != null) {
      onFilePicked(result.files.single.path!);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Tidak ada file yang dipilih')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _pickFile(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(Icons.attach_file, color: Colors.grey),
            SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }
}
