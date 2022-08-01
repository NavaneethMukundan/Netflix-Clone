import 'package:flutter/material.dart';
import 'package:netflix/core/colors/colors.dart';
import 'package:netflix/core/colors/constrants.dart';
import 'package:netflix/domain/downloads/models/downloads.dart';
import 'package:video_player/video_player.dart';

import '../../../application/fast_laugh/fast_laugh_bloc.dart';

class VideoListInheritedWidget extends InheritedWidget {
  final Widget widget;
  final Downloads movieData;

  VideoListInheritedWidget(
      {Key? key, required this.widget, required this.movieData})
      : super(key: key, child: widget);

  @override
  bool updateShouldNotify(covariant VideoListInheritedWidget oldWidget) {
    return oldWidget.movieData != movieData;
  }

  static VideoListInheritedWidget? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<VideoListInheritedWidget>();
  }
}

class VideoListItem extends StatelessWidget {
  const VideoListItem({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    final posterPath =
        VideoListInheritedWidget.of(context)?.movieData.posterPath;
    final videoUrl = trailVideoUrls[index % trailVideoUrls.length];
    return Stack(
      children: [
        FastLaughVidoPlayer(videoUrl: videoUrl, onStateChanged: (bool) {}),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                //left side
                CircleAvatar(
                  backgroundColor: Colors.black.withOpacity(0.5),
                  radius: 30,
                  child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.volume_off,
                        color: Colors.white,
                        size: 30,
                      )),
                ),

                //right side
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: posterPath == null
                            ? null
                            : NetworkImage('$imageAppendUrl$posterPath'),
                      ),
                    ),
                    const VideoActionsPage(
                        icon: Icons.emoji_emotions, title: 'lol'),
                    const VideoActionsPage(icon: Icons.add, title: 'My List'),
                    const VideoActionsPage(icon: Icons.share, title: 'Share'),
                    const VideoActionsPage(
                        icon: Icons.play_arrow, title: 'Play')
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class VideoActionsPage extends StatelessWidget {
  final IconData icon;

  final String title;
  const VideoActionsPage({Key? key, required this.icon, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 30,
          ),
          Text(
            title,
            style: const TextStyle(color: kWhite, fontSize: 15),
          ),
        ],
      ),
    );
  }
}

class FastLaughVidoPlayer extends StatefulWidget {
  final String videoUrl;
  final void Function(bool isPlaying) onStateChanged;
  const FastLaughVidoPlayer(
      {Key? key, required this.videoUrl, required this.onStateChanged})
      : super(key: key);

  @override
  State<FastLaughVidoPlayer> createState() => _FastLaughVidoPlayerState();
}

class _FastLaughVidoPlayerState extends State<FastLaughVidoPlayer> {
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    _videoPlayerController = VideoPlayerController.network(widget.videoUrl);
    _videoPlayerController.initialize().then((value) {
      setState(() {
        _videoPlayerController.play();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: _videoPlayerController.value.isInitialized
          ? AspectRatio(
              aspectRatio: _videoPlayerController.value.aspectRatio,
              child: VideoPlayer(_videoPlayerController),
            )
          : const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            ),
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }
}
