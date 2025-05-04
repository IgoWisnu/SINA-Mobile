// small_text_field.dart
import 'package:flutter/material.dart';

class SmallTextField extends StatelessWidget {
  const SmallTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50, // Adjust width a bit bigger to fit icon + textfield
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: TextEditingController(text: '0'),
              decoration: const InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 8),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
              keyboardType: TextInputType.number,
              style: const TextStyle(fontSize: 14),
            ),
          ),
          const Icon(
            Icons.edit,
            size: 18, // Small icon size
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
