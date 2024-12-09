import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget(
      {super.key,
      required this.controller,
      this.hintText,
      this.labelText,
      this.labelFontSize,
      this.hintFontSize,
      this.suffixIcon,
      this.prefixIcon,
      this.borderColor,
      this.keyboardType});

  final TextEditingController controller;
  final String? hintText, labelText;
  final double? labelFontSize, hintFontSize;
  final Widget? suffixIcon, prefixIcon;
  final Color? borderColor;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        keyboardType: keyboardType ?? TextInputType.emailAddress,
        cursorColor: Colors.white,
        controller: controller,
        style: const TextStyle(fontSize: 18, color: Colors.white),
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          labelStyle: TextStyle(fontSize: labelFontSize, fontWeight: FontWeight.bold, color: Colors.grey.shade200),
          hintStyle: TextStyle(fontSize: hintFontSize, color: Colors.grey.shade200),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: borderColor ?? Colors.blue.shade900, width: 3),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: borderColor ?? Colors.blue.shade900, width: 2),
          ),
        ),
      ),
    );
  }
}
