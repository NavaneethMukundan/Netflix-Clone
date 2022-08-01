import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix/application/search/search_bloc.dart';
import 'package:netflix/core/colors/colors.dart';
import 'package:netflix/core/colors/constrants.dart';
import 'package:netflix/presentation/search/widgets/title.dart';

class SearchIdleScreen extends StatelessWidget {
  const SearchIdleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SeachTextTitle(title: 'Top Searches'),
        kheight,
        Expanded(
          child: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state.isError) {
                return const Center(
                  child: Text('Error While Getting Data'),
                );
              } else if (state.idleList.isEmpty) {
                return const Center(
                  child: Text('List is Empty'),
                );
              }
              return ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final movie = state.idleList[index];
                    return TopSearchItem(
                        imageUrl: '$imageAppendUrl${movie.posterPath}',
                        title: movie.title ?? "No Title Provided");
                  },
                  separatorBuilder: (context, index) => kheight20,
                  itemCount: state.idleList.length);
            },
          ),
        )
      ],
    );
  }
}

class TopSearchItem extends StatelessWidget {
  final String title;
  final String imageUrl;
  const TopSearchItem({Key? key, required this.imageUrl, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Container(
          width: screenWidth * 0.35,
          height: 65,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover, image: NetworkImage(imageUrl))),
        ),
        const SizedBox(
          width: 6,
        ),
        Expanded(
            child: Text(
          title,
          style: const TextStyle(
              color: kWhite, fontWeight: FontWeight.bold, fontSize: 16),
        )),
        const CircleAvatar(
          backgroundColor: kWhite,
          radius: 25,
          child: CircleAvatar(
            backgroundColor: kBlackColor,
            radius: 23,
            child: Icon(
              CupertinoIcons.play_fill,
              color: kWhite,
            ),
          ),
        )
      ],
    );
  }
}
