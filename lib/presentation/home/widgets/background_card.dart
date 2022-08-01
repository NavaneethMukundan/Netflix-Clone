import 'package:flutter/material.dart';
import 'package:netflix/core/colors/colors.dart';
import 'package:netflix/core/colors/constrants.dart';

import 'custom_button.dart';

class BackgroundCard extends StatelessWidget {
  const BackgroundCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 550,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(mainImage), fit: BoxFit.cover)),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const CustomButtonWidget(icon: Icons.add, title: 'My List'),
                _playButton(),
                const CustomButtonWidget(icon: Icons.info, title: 'Info'),
              ],
            ),
          ),
        )
      ],
    );
  }

  TextButton _playButton() {
    return TextButton.icon(
        onPressed: () {},
        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(kWhite)),
        icon: const Icon(
          Icons.play_arrow,
          size: 30,
          color: kBlackColor,
        ),
        label: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'Play',
            style: TextStyle(fontSize: 20, color: kBlackColor),
          ),
        ));
  }
}
