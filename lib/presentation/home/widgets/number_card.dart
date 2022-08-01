import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:netflix/core/colors/colors.dart';
import 'package:netflix/core/colors/constrants.dart';

class NumberCard extends StatelessWidget {
  const NumberCard({Key? key, required this.index, required this.imageUrl})
      : super(key: key);

  final int index;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            const SizedBox(
              width: 40,
              height: 150,
            ),
            Container(
              width: 130,
              height: 250,
              decoration: BoxDecoration(
                borderRadius: kRadius10,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(imageUrl),
                ),
              ),
            ),
          ],
        ),
        Positioned(
          left: 13,
          bottom: -20,
          child: BorderedText(
            strokeWidth: 10.0,
            strokeColor: kWhite,
            child: Text(
              "${index + 1}",
              style: const TextStyle(
                  fontSize: 130,
                  decoration: TextDecoration.none,
                  color: kBlackColor),
            ),
          ),
        )
      ],
    );
  }
}
