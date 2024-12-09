import 'package:flutter/material.dart';

class TfWidget extends StatelessWidget {
  const TfWidget({super.key, required this.msgCtrl});

  final TextEditingController msgCtrl;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: 3,
      cursorColor: Colors.black54,
      controller: msgCtrl,
      style: const TextStyle(fontSize: 18, color: Colors.white),
      decoration: InputDecoration(
        hintText: "Enter text",
        labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey.shade600),
        hintStyle: TextStyle(fontSize: 16, color: Colors.grey.shade600),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.blue.shade900, width: 3),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.blue.shade900, width: 2),
        ),
      ),
    );
  }
}