import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movieapp/provider/keywors_provider.dart';
import 'package:movieapp/provider/popular_provider.dart';
import 'package:movieapp/provider/video_provider.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailsScreen extends StatefulWidget {
  var index;

  DetailsScreen({this.index});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  var i2;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    var poprovider = Provider.of<PopularProvider>(context, listen: false);

    Provider.of<videos>(context)
        .getvedios(poprovider.populars.results![widget.index].id);
    Provider.of<KeyWordsProvider>(context)
        .getKeyWords(poprovider.populars.results![widget.index].id);
    setState(() {});

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var ved = Provider.of<videos>(context, listen: false);
    var keyWords = Provider.of<KeyWordsProvider>(context);
    // i2 = poprovider.populars.results![widget.index].id;
    //var vedacess = Provider.of<videos>(context).findByid(i2);
    var poprovider = Provider.of<PopularProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        elevation: 8.0,
        backgroundColor: Colors.grey[800],
        title: Text(poprovider.populars.results![widget.index].originalTitle
            .toString()),
      ),
      body: Consumer<PopularProvider>(
        builder: (context, Popular, child) {
          return Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    // ------------top-----------------------
                    Stack(
                      fit: StackFit.passthrough,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 300,
                          child: ImageFiltered(
                            imageFilter:
                                ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
                            child: Image.network(
                              'https://www.themoviedb.org/t/p/w600_and_h900_bestv2/' +
                                  Popular.populars.results![widget.index]
                                      .posterPath
                                      .toString(),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(18),
                            child: SizedBox(
                              height: 200,
                              child: Card(
                                elevation: 1.0,
                                child: Image.network(
                                  'https://www.themoviedb.org/t/p/w600_and_h900_bestv2/' +
                                      Popular.populars.results![widget.index]
                                          .posterPath
                                          .toString(),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 170.0, top: 50),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  '(' +
                                      Popular.populars.results![widget.index]
                                          .releaseDate!.year
                                          .toString() +
                                      ')',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                  Popular.populars.results![widget.index]
                                      .originalTitle
                                      .toString(),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text('Rate :',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(60),
                                    child: Container(
                                      width: 65,
                                      height: 30,
                                      child: Card(
                                        elevation: 2.0,
                                        color: Colors.grey.withOpacity(0.4),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.star,
                                              color: Colors.yellowAccent,
                                              size: 20,
                                            ),
                                            Text(
                                              Popular
                                                  .populars
                                                  .results![widget.index]
                                                  .voteAverage
                                                  .toString(),
                                              style: const TextStyle(
                                                  color: Colors.black87,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 70,
                    ),
                    //--------------overView----------------------
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "OverView",
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: Divider(
                        color: Colors.black45,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            Popular.populars.results![widget.index].overview
                                .toString(),
                            textDirection: TextDirection.ltr,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),

                    //--------------if video available----------------------

                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: ved.key == null
                          ? Container(
                              color: Colors.red,
                              child: Card(
                                elevation: 8.0,
                                color: Colors.transparent,
                                child: Text(
                                  "official trailer not avialable..!",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "official trailer",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                Divider(
                                  color: Colors.black45,
                                  height: 10,
                                  thickness: 1.5,
                                ),
                                Container(
                                  width: 400,
                                  height: 300,
                                  child: youtubeview(
                                    vedioKey: ved.key,
                                  ),
                                ),
                              ],
                            ),
                    ),
                    //--------------KeyWords----------------------

                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('KeyWords',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 90.0),
                      child: Divider(
                        color: Colors.black45,
                        height: 10,
                        thickness: 1.5,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: keyWords.name == null
                          ? Card(child: Text(''))
                          : Container(
                              child: Container(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Container(
                                        color: Colors.grey[300],
                                        child: Card(
                                          elevation: 8.0,
                                          color: Colors.transparent,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              keyWords.name.toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                ],
                              ),
                            )),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class youtubeview extends StatefulWidget {
  final String? vedioKey;

  const youtubeview({this.vedioKey});
  @override
  State<youtubeview> createState() => _youtubeviewState();
}

class _youtubeviewState extends State<youtubeview> {
  late YoutubePlayerController _controller;

  void youtubPlayer() {
    _controller = YoutubePlayerController(
        initialVideoId: widget.vedioKey.toString(),
        flags: const YoutubePlayerFlags(
            autoPlay: false, enableCaption: false, isLive: false));
  }

  @override
  void initState() {
    youtubPlayer();
    print('hi');
    super.initState();
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(controller: _controller),
      builder: (ctx, player) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              width: 200,
              height: 100,
              child: YoutubePlayer(
                controller: _controller,
                bottomActions: [
                  CurrentPosition(),
                  ProgressBar(isExpanded: true),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
