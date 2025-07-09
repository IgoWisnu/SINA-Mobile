import 'package:flutter/material.dart';
import 'package:sina_mobile/View/Lib/Colors.dart';

class CustomFlexDropdown<T> extends StatelessWidget {
  final List<T> items;
  final T? selectedItem;
  final ValueChanged<T?> onChanged;
  final String Function(T) itemToString;

  const CustomFlexDropdown({
    Key? key,
    required this.items,
    required this.selectedItem,
    required this.onChanged,
    required this.itemToString,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 160,
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton<T>(
        isExpanded: true,
        underline: const SizedBox(), // Menghilangkan garis bawah
        value: selectedItem,
        onChanged: onChanged,
        items: items.map<DropdownMenuItem<T>>((T value) {
          return DropdownMenuItem<T>(
            value: value,
            child: Text(itemToString(value)),
          );
        }).toList(),
      ),
    );
  }
}
