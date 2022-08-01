import 'package:flutter/material.dart';
import 'package:netflix/core/colors/colors.dart';
import 'package:netflix/core/colors/constrants.dart';
import 'package:netflix/presentation/home/widgets/custom_button.dart';
import 'package:netflix/presentation/widgets/video_widget.dart';

class ComingSoonWidget extends StatelessWidget {
  final String id;
  final String month;
  final String day;
  final String posterPath;
  final String movieName;
  final String discription;

  const ComingSoonWidget(
      {Key? key,
      required this.id,
      required this.month,
      required this.day,
      required this.posterPath,
      required this.movieName,
      required this.discription})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Row(
      children: [
        SizedBox(
          width: 50,
          height: 500,
          child: Column(children: [
            Text(
              month,
              style: const TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold, color: kGreyColor),
            ),
            Text(
              day,
              style: const TextStyle(
                  fontSize: 30, fontWeight: FontWeight.bold, letterSpacing: 4),
            )
          ]),
        ),
        SizedBox(
          width: size.width - 50,
          height: 450,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            VideoWidget(url: posterPath),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    movieName,
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                    style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -5),
                  ),
                ),
                // const Spacer(),
                Row(
                  children: const [
                    CustomButtonWidget(
                      icon: Icons.all_out_sharp,
                      title: 'Remind Me',
                      iconSize: 20,
                      textSize: 20,
                    ),
                    kWidth,
                    CustomButtonWidget(
                      icon: Icons.info,
                      title: 'Info',
                      iconSize: 20,
                      textSize: 20,
                    ),
                    kWidth
                  ],
                ),
              ],
            ),
            Text(
              ('Coming On $day $month'),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            kheight,
            Text(
              movieName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            kheight,
            Text(
              discription,
              maxLines: 4,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: kGreyColor),
            ),
          ]),
        ),
      ],
    );
  }
}
