import 'package:flutter/material.dart';
import 'package:netflix/core/colors/colors.dart';
import 'package:netflix/presentation/downloads/widgets/screen_downloads.dart';
import 'package:netflix/presentation/fast_laugh/fast_laugh_screen.dart';
import 'package:netflix/presentation/home/home.dart';
import 'package:netflix/presentation/main_page/widgets/navigaton_bar.dart';
import 'package:netflix/presentation/new_and_hot/new_and_hot_screen.dart';
import 'package:netflix/presentation/search/search_page.dart';

class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);

  final _pages = [
    const HomeScreen(),
    const NewAndHotScreen(),
    const FastLaughScreen(),
    SearchPage(),
    DownloadScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: ValueListenableBuilder(
              valueListenable: indexChangeNotifier,
              builder: (context, int index, _) {
                return _pages[index];
              }),
        ),
        bottomNavigationBar: const NavigationScreen());
  }
}
