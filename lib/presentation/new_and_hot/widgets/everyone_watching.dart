import 'package:flutter/material.dart';
import 'package:netflix/core/colors/colors.dart';
import 'package:netflix/core/colors/constrants.dart';
import 'package:netflix/presentation/home/widgets/custom_button.dart';
import 'package:netflix/presentation/widgets/video_widget.dart';

class EveryOneWatchingWidget extends StatelessWidget {
  final String posterPath;
  final String movieName;
  final String discription;

  const EveryOneWatchingWidget(
      {Key? key,
      required this.posterPath,
      required this.movieName,
      required this.discription})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        kheight,
        Text(
          movieName,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        kheight,
        Text(
          discription,
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: kGreyColor),
        ),
        kheight50,
        VideoWidget(
          url: posterPath,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const CustomButtonWidget(
              icon: Icons.share,
              title: 'Share',
              iconSize: 30,
              textSize: 16,
            ),
            kWidth,
            const CustomButtonWidget(
              icon: Icons.add,
              title: 'My List',
              iconSize: 30,
              textSize: 16,
            ),
            kWidth,
            const CustomButtonWidget(
              icon: Icons.play_arrow,
              title: 'Play',
              iconSize: 30,
              textSize: 16,
            ),
          ],
        )
      ],
    );
  }
}
