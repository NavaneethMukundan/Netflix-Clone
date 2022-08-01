import 'package:flutter/material.dart';

class SeachTextTitle extends StatelessWidget {
  final String title;
  const SeachTextTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    );
  }
}
