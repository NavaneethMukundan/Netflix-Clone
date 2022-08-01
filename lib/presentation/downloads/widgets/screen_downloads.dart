import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix/application/downloads/downloads_bloc.dart';
import 'package:netflix/core/colors/colors.dart';
import 'package:netflix/core/colors/constrants.dart';
import 'package:netflix/presentation/widgets/app_bar_widget.dart';

class DownloadScreen extends StatelessWidget {
  DownloadScreen({Key? key}) : super(key: key);

  final _widgetList = [
    const _smartDownload(),
    const Section2(),
    const Section3()
  ];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: AppBarScreen(
              title: "Downloads",
            )),
        body: ListView.separated(
            padding: const EdgeInsets.all(10),
            itemBuilder: (context, index) => _widgetList[index],
            separatorBuilder: (ctx, index) => const SizedBox(
                  height: 20,
                ),
            itemCount: _widgetList.length));
  }
}

class _smartDownload extends StatelessWidget {
  const _smartDownload({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Icon(
          Icons.settings,
          color: kWhite,
        ),
        kWidth,
        Text(
          'Smart Downloads',
          style: TextStyle(fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}

class DownloadsImageWidget extends StatelessWidget {
  const DownloadsImageWidget(
      {Key? key,
      required this.imageList,
      this.angle = 0,
      required this.margin,
      required this.size})
      : super(key: key);

  final String imageList;
  final double angle;
  final EdgeInsets margin;
  final Size size;

  @override
  Widget build(BuildContext context) {
    // final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: margin,
      child: Transform.rotate(
        angle: angle * pi / 180,
        child: Container(
          //margin: margin,
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: kBlackColor,
              image: DecorationImage(
                  image: NetworkImage(imageList), fit: BoxFit.cover)),
        ),
      ),
    );
  }
}

class Section2 extends StatelessWidget {
  const Section2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<DownloadsBloc>(context)
          .add(const DownloadsEvent.getDownloadsImage());
    });
    // BlocProvider.of<DownloadsBloc>(context)
    //     .add(const DownloadsEvent.getDownloadsImage());
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        const Text(
          'Introducing download for you',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: kWhite, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        kheight,
        const Text(
          "We will downloada personalised selection of \nmovies and shows for you, so there's\n always something to watch on your\n devices",
          style: TextStyle(
              color: Colors.grey, fontSize: 16, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        kheight,
        BlocBuilder<DownloadsBloc, DownloadState>(
          builder: (context, state) {
            return SizedBox(
              width: size.width,
              height: size.width,
              child: state.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : state.downloads!.isEmpty
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Stack(
                          alignment: Alignment.center,
                          children: [
                            Center(
                              child: CircleAvatar(
                                backgroundColor: Colors.grey.withOpacity(0.5),
                                radius: size.width * 0.38,
                              ),
                            ),
                            DownloadsImageWidget(
                                size:
                                    Size(size.width * 0.35, size.width * 0.55),
                                angle: 25,
                                imageList:
                                    '$imageAppendUrl${state.downloads![0].posterPath}',
                                margin:
                                    const EdgeInsets.only(left: 130, top: 30)),
                            DownloadsImageWidget(
                                size:
                                    Size(size.width * 0.35, size.width * 0.55),
                                angle: -25,
                                imageList:
                                    '$imageAppendUrl${state.downloads![1].posterPath}',
                                margin:
                                    const EdgeInsets.only(right: 140, top: 30)),
                            DownloadsImageWidget(
                                size: Size(size.width * 0.4, size.width * 0.6),
                                imageList:
                                    '$imageAppendUrl${state.downloads![3].posterPath}',
                                margin:
                                    const EdgeInsets.only(bottom: 14, top: 30))
                          ],
                        ),
            );
          },
        ),
      ],
    );
  }
}

class Section3 extends StatelessWidget {
  const Section3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            color: buttonColorBlue,
            onPressed: () {},
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'setup',
                style: TextStyle(
                  color: kWhite,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        kheight,
        MaterialButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          color: buttonColorWhite,
          onPressed: () {},
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'See what you can download',
              style: TextStyle(
                color: kBlackColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        )
      ],
    );
  }
}
