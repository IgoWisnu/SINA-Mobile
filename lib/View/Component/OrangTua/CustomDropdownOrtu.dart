import 'package:flutter/material.dart';
import 'package:sina_mobile/View/Lib/Colors.dart';

class CustomDropdownOrtu extends StatefulWidget {
  final List<String> items;
  final String selectedItem;
  final ValueChanged<String?> onChanged;

  const CustomDropdownOrtu({
    Key? key,
    required this.items,
    required this.selectedItem,
    required this.onChanged,
  }) : super(key: key);

  @override
  _CustomDropdownOrtuState createState() => _CustomDropdownOrtuState();
}

class _CustomDropdownOrtuState extends State<CustomDropdownOrtu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 160,
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        underline: SizedBox(), // Remove default underline
        value: widget.selectedItem,
        onChanged: widget.onChanged,
        items:
            widget.items.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: TextStyle()),
              );
            }).toList(),
      ),
    );
  }
}
