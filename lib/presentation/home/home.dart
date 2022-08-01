import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix/application/home/home_bloc.dart';
import 'package:netflix/core/colors/constrants.dart';
import 'package:netflix/presentation/home/widgets/background_card.dart';
import 'package:netflix/presentation/home/widgets/number_title_card.dart';
import 'package:netflix/presentation/widgets/main_title_card.dart';

ValueNotifier<bool> scrollNotifier = ValueNotifier(true);

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<HomeBloc>(context).add(const GetHomeScreenData());
    });
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: scrollNotifier,
        builder: (BuildContext ctx, index, _) {
          return NotificationListener<UserScrollNotification>(
            onNotification: (notification) {
              final ScrollDirection direction = notification.direction;
              if (direction == ScrollDirection.reverse) {
                scrollNotifier.value = false;
              } else if (direction == ScrollDirection.forward) {
                scrollNotifier.value = true;
              }
              return true;
            },
            child: Stack(
              children: [
                BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if (state.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      );
                    } else if (state.hasError) {
                      return const Center(
                          child: Text('Error while getting data'));
                    }
                    // Released In the Past Year
                    final _releasedPastYear = state.pastYearMovieList.map((m) {
                      return '$imageAppendUrl${m.posterPath}';
                    }).toList();

                    // trending
                    final _trending = state.trendingMovieList.map((m) {
                      return '$imageAppendUrl${m.posterPath}';
                    }).toList();
                    // 10s Drams
                    final _10sDrams = state.tensDramsMovieList.map((m) {
                      return '$imageAppendUrl${m.posterPath}';
                    }).toList();

                    // Sount indian Movies
                    final _southIndian = state.southIndianMovieList.map((m) {
                      return '$imageAppendUrl${m.posterPath}';
                    }).toList();
                    _southIndian.shuffle();

                    // top 10 tv shows
                    final _top10tv = state.trendingTvList.map((t) {
                      return '$imageAppendUrl${t.posterPath}';
                    }).toList();
                    _top10tv.shuffle();

                    // List View
                    return ListView(
                      children: [
                        BackgroundCard(),
                        MainTitleCard(
                          title: 'Released In the Past Year',
                          posterList: _releasedPastYear.sublist(0, 10),
                        ),
                        kheight,
                        MainTitleCard(
                          title: 'Trending Now',
                          posterList: _trending.sublist(0, 10),
                        ),
                        kheight,
                        NumberTitleCard(postersList: _top10tv.sublist(0, 10)),
                        kheight,
                        MainTitleCard(
                          title: 'Tense Dramas',
                          posterList: _10sDrams.sublist(0, 10),
                        ),
                        kheight,
                        MainTitleCard(
                          title: 'South Indian Cinemas',
                          posterList: _southIndian.sublist(0, 10),
                        ),
                        kheight,
                      ],
                    );
                  },
                ),
                scrollNotifier.value == true
                    ? AnimatedContainer(
                        duration: const Duration(seconds: 2),
                        width: double.infinity,
                        height: 90,
                        color: Colors.black.withOpacity(0.5),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Image.network(
                                  'https://pngimg.com/uploads/netflix/netflix_PNG10.png',
                                  width: 70,
                                  height: 60,
                                ),
                                const Spacer(),
                                const Icon(
                                  Icons.cast,
                                  color: Colors.white,
                                ),
                                kWidth,
                                Container(
                                  width: 30,
                                  height: 30,
                                  color: Colors.blue,
                                ),
                                kWidth
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'TV Shows',
                                  style: kHomeTextStyle,
                                ),
                                Text(
                                  'Movies',
                                  style: kHomeTextStyle,
                                ),
                                Text(
                                  'Categories',
                                  style: kHomeTextStyle,
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    : kheight
              ],
            ),
          );
        },
      ),
    );
  }
}
