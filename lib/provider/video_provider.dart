import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movieapp/models/popular.dart';
import 'package:http/http.dart' as http;
import 'package:movieapp/models/top_rated.dart';
import 'package:movieapp/models/videos.dart';

class videos with ChangeNotifier {
  var popmovie = PopularMovie();
  Movievedio movievedio = Movievedio();
  var key;
  var title;
  Future<void> getvedios(int? index) async {
    final responce = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/${index}/videos?api_key=d6059b1e6561f2f6cc633a68a0416703'));
    final pomov1 = await json.decode(responce.body);

    final res = movievedioFromJson(responce.body);
    movievedio = res;
    if (res.results!.length == 1) {
      if (index == res.id) {
        key = res.results!.map((e) => e.key).first;
        notifyListeners();
      }
    } else {
      key = null;
      notifyListeners();
    }

    //print(res.results!.map((e) => e.key));
  }
}
