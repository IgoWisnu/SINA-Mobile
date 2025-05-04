import 'package:flutter/material.dart';

class AddButton extends StatelessWidget{
  final VoidCallback onPressed;

  const AddButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FloatingActionButton(
        onPressed: onPressed,
        child: Icon(Icons.add),
    );
  }

}