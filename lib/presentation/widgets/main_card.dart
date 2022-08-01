import 'package:flutter/material.dart';
import '../../core/colors/constrants.dart';

class MainCardPage extends StatelessWidget {
  final String imageUrl;
  const MainCardPage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        width: 130,
        height: 250,
        decoration: BoxDecoration(
          borderRadius: kRadius10,
          image: DecorationImage(
            image: NetworkImage(imageUrl),
          ),
        ),
      ),
    );
  }
}
