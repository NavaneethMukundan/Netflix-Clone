import 'package:flutter/material.dart';
import 'package:netflix/core/colors/constrants.dart';
import 'package:netflix/presentation/widgets/main_card.dart';
import 'package:netflix/presentation/widgets/main_title.dart';

class MainTitleCard extends StatelessWidget {
  const MainTitleCard({Key? key, required this.title, required this.posterList})
      : super(key: key);
  final String title;
  final List<String> posterList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MainTileScreen(title: title),
        kheight,
        LimitedBox(
          maxHeight: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: List.generate(
                posterList.length,
                (index) => MainCardPage(
                      imageUrl: posterList[index],
                    )),
          ),
        )
      ],
    );
  }
}
