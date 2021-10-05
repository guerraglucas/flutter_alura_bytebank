import 'package:flutter/material.dart';

class Editor extends StatelessWidget {
  final TextEditingController? controller;
  final String? fieldName;
  final String? fieldHint;
  final Icon? icon;
  final TextInputType? keyboardType;

  const Editor(
      {Key? key,
      this.controller,
      this.fieldName,
      this.fieldHint,
      this.icon,
      this.keyboardType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        style: TextStyle(
          fontSize: 24.0,
        ),
        decoration: InputDecoration(
          icon: icon,
          labelText: fieldName,
          hintText: fieldHint,
        ),
        keyboardType: keyboardType,
        textCapitalization: TextCapitalization.words,
      ),
    );
  }
}
