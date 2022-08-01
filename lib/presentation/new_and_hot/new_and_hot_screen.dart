import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:netflix/application/hot_and_new/hot_and_new_bloc.dart';
import 'package:netflix/core/colors/colors.dart';
import 'package:netflix/presentation/new_and_hot/widgets/comeing_soon.dart';
import 'package:netflix/presentation/new_and_hot/widgets/everyone_watching.dart';

import '../../core/colors/constrants.dart';

class NewAndHotScreen extends StatelessWidget {
  const NewAndHotScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(80),
            child: AppBar(
              title: const Text(
                'New & Hot',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
              ),
              actions: [
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
              ],
              bottom: TabBar(
                isScrollable: true,
                unselectedLabelColor: kWhite,
                labelColor: kBlackColor,
                labelStyle:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                indicator:
                    BoxDecoration(color: kWhite, borderRadius: kRadius30),
                tabs: const [
                  Tab(
                    text: "🍿Coming Soon",
                  ),
                  Tab(
                    text: "👀 Everyon's Watching",
                  ),
                ],
              ),
            )),
        body: const TabBarView(children: [
          ComingSoonList(
            key: Key('coming_soon'),
          ),
          EveryOneIsWatchingList(
            key: Key('everyone is Watching'),
          ),
        ]),
      ),
    );
  }
}

class EveryOneIsWatchingList extends StatelessWidget {
  const EveryOneIsWatchingList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<HotAndNewBloc>(context)
          .add(const LoadDataInEveryOneiSWatching());
    });
    return BlocBuilder<HotAndNewBloc, HotAndNewState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          );
        } else if (state.hasError) {
          return const Center(
              child: Text('Error while loading coming soon list'));
        } else if (state.everyoneIsWtchingList.isEmpty) {
          return const Center(child: Text('coming soon list is empty'));
        } else {
          return ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: state.everyoneIsWtchingList.length,
              itemBuilder: (context, index) {
                final movie = state.everyoneIsWtchingList[index];
                if (movie.id == null) {
                  return const SizedBox();
                }

                final Tv = state.everyoneIsWtchingList[index];

                return EveryOneWatchingWidget(
                  posterPath: '$imageAppendUrl${Tv.posterPath}',
                  movieName: Tv.originalName ?? ' No Name Provided',
                  discription: Tv.overview ?? " No Discription",
                );
              });
        }
      },
    );
  }
}

class ComingSoonList extends StatelessWidget {
  const ComingSoonList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<HotAndNewBloc>(context).add(const LoadDataInComingSoon());
    });
    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<HotAndNewBloc>(context)
            .add(const LoadDataInComingSoon());
      },
      child: BlocBuilder<HotAndNewBloc, HotAndNewState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            );
          } else if (state.hasError) {
            return const Center(
                child: Text('Error while loading coming soon list'));
          } else if (state.comingSoonList.isEmpty) {
            return const Center(child: Text('coming soon list is empty'));
          } else {
            return ListView.builder(
                padding: const EdgeInsets.only(top: 20),
                itemCount: state.comingSoonList.length,
                itemBuilder: (context, index) {
                  final movie = state.comingSoonList[index];
                  if (movie.id == null) {
                    return const SizedBox();
                  }
                  String month = '';
                  String day = '';
                  try {
                    final _date = DateTime.parse(movie.releaseDate!);
                    final formatedData =
                        DateFormat.yMMMd('en_US').format(_date);
                    month = formatedData.split(' ').first.substring(0, 3);
                    day = movie.releaseDate!.split('-')[1];
                  } catch (_) {
                    month = '';
                    day = '';
                  }

                  return ComingSoonWidget(
                      id: movie.id.toString(),
                      month: month,
                      day: day,
                      posterPath: '$imageAppendUrl${movie.posterPath}',
                      movieName: movie.originalTitle ?? 'No Title',
                      discription: movie.overview ?? 'No Discreption');
                });
          }
        },
      ),
    );
  }
}
