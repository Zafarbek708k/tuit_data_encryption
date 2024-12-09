import 'package:flutter/material.dart';
import 'package:tuit_data_encryption/feature/widgets/custom_text_widget.dart';

class ResultWidget extends StatelessWidget {
  const ResultWidget({super.key, required this.result});

  final String result;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.green, width: 2),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(
          children: [
            CustomTextWidget(result, color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 16),
          ],
        ),
      ),
    );
  }
}