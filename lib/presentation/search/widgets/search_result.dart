import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix/application/search/search_bloc.dart';
import 'package:netflix/core/colors/constrants.dart';
import 'package:netflix/presentation/search/widgets/title.dart';

class SearchResultScreen extends StatelessWidget {
  const SearchResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SeachTextTitle(title: 'Movies & TV'),
        kheight,
        Expanded(child: BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            return GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              mainAxisSpacing: 5,
              crossAxisSpacing: 9,
              childAspectRatio: 1 / 2,
              children: List.generate(state.searchResultList.length, (index) {
                final movie = state.searchResultList[index];
                return MainCard(
                  imageUrl: movie.posterImageUrl,
                );
              }),
            );
          },
        ))
      ],
    );
  }
}

class MainCard extends StatelessWidget {
  final String imageUrl;
  const MainCard({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image:
            DecorationImage(fit: BoxFit.cover, image: NetworkImage(imageUrl)),
        borderRadius: BorderRadius.circular(7),
      ),
    );
  }
}
