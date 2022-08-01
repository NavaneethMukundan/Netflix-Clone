import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix/application/search/search_bloc.dart';
import 'package:netflix/core/colors/constrants.dart';
import 'package:netflix/domain/core/debounce/debounce.dart';
import 'package:netflix/presentation/search/widgets/search_idle_ui.dart';
import 'package:netflix/presentation/search/widgets/search_result.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);

  final _debouncer = Debouncer(milliseconds: 1);

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   BlocProvider.of<SearchBloc>(context).add(const initialize());
    // });
    BlocProvider.of<SearchBloc>(context).add(const initialize());
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.all(14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CupertinoSearchTextField(
            backgroundColor: Colors.grey.withOpacity(0.4),
            prefixIcon: const Icon(
              CupertinoIcons.search,
              color: Colors.grey,
            ),
            suffixIcon: const Icon(
              CupertinoIcons.xmark_circle_fill,
              color: Colors.grey,
            ),
            style: const TextStyle(color: Colors.white),
            onChanged: (value) {
              if (value.isNotEmpty) {
                return;
              }
              // _debouncer.run(() {

              // });
              BlocProvider.of<SearchBloc>(context)
                  .add(searchMovie(movieQuery: value));
            },
          ),
          kheight,
          Expanded(child: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              if (state.searchResultList.isEmpty) {
                return const SearchIdleScreen();
              } else {
                return const SearchResultScreen();
              }
            },
          )),
        ],
      ),
    )));
  }
}
