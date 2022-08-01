import 'package:flutter/material.dart';
import 'package:netflix/core/colors/constrants.dart';
import 'package:netflix/presentation/home/widgets/number_card.dart';
import 'package:netflix/presentation/widgets/main_title.dart';

class NumberTitleCard extends StatelessWidget {
  const NumberTitleCard({Key? key, required this.postersList})
      : super(key: key);

  final List<String> postersList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const MainTileScreen(title: 'Top 10 TV Shows In India Today'),
        kheight,
        LimitedBox(
          maxHeight: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: List.generate(
                10,
                (index) => NumberCard(
                      index: index,
                      imageUrl: postersList[index],
                    )),
          ),
        )
      ],
    );
  }
}
