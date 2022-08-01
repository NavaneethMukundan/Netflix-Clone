import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix/presentation/fast_laugh/widgets/video_list_item.dart';

import '../../application/fast_laugh/fast_laugh_bloc.dart';

class FastLaughScreen extends StatelessWidget {
  const FastLaughScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   BlocProvider.of<FastLaughBloc>(context).add(const Initialize());
    // });
    BlocProvider.of<FastLaughBloc>(context).add(const Initialize());
    return Scaffold(body: SafeArea(
      child: BlocBuilder<FastLaughBloc, FastLaughState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.isError) {
            return const Center(
              child: Text('Error While Getting '),
            );
          } else if (state.videoList.isEmpty) {
            return const Center(child: Text('Video List is Empty '));
          } else {
            return PageView(
                scrollDirection: Axis.vertical,
                children: List.generate(state.videoList.length, (index) {
                  return VideoListInheritedWidget(
                    movieData: state.videoList[index],
                    widget:
                        VideoListItem(key: Key(index.toString()), index: index),
                  );
                }));
          }
        },
      ),
    ));
  }
}
