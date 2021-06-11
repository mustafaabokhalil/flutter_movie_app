import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:movieapp/provider/keywors_provider.dart';
import 'package:movieapp/provider/popular_provider.dart';
import 'package:movieapp/provider/top_rated_provider.dart';
import 'package:movieapp/provider/video_provider.dart';
import 'package:movieapp/widgets/popular_grid.dart';
import 'package:movieapp/widgets/top_rated_gride.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

main(List<String> args) {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<PopularProvider>(
          create: (ctx) => PopularProvider(),
        ),
        ChangeNotifierProvider<TopRatedProvider>(
          create: (ctx) => TopRatedProvider(),
        ),
        ChangeNotifierProvider<videos>(
          create: (ctx) => videos(),
        ),
        ChangeNotifierProvider<KeyWordsProvider>(
            create: (ctx) => KeyWordsProvider())
      ],
      child: MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final poprov = Provider.of<PopularProvider>(context, listen: false);
    final topRatedProvider =
        Provider.of<TopRatedProvider>(context, listen: false);
    print('main');
    return DefaultTabController(
        length: 2,
        child: FutureBuilder(
          future:
              Provider.of<PopularProvider>(context, listen: false).getMovie(),
          builder: (ctx, snap) => Scaffold(
            backgroundColor: Colors.grey[800],
            appBar: AppBar(
              backgroundColor: Colors.black54,
              elevation: 8.0,
              title: const Text('Movie App'),
              centerTitle: true,
              titleSpacing: 20,
              flexibleSpace: Container(),
              bottom: const TabBar(
                tabs: [
                  Tab(
                    text: 'Popular',
                  ),
                  Tab(
                    text: 'Top Rated',
                  ),
                ],
              ),
            ),
            body: TabBarView(children: [
              poprov.resul == null
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : PopularGride(),
              FutureBuilder(
                  future: Provider.of<TopRatedProvider>(context, listen: false)
                      .getTopRated(),
                  builder: (ctx, snap) => TopRatedGride()),
            ]),
          ),
        ));
  }
}
