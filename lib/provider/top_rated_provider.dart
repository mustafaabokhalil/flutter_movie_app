import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movieapp/models/popular.dart';
import 'package:http/http.dart' as http;
import 'package:movieapp/models/top_rated.dart';

class TopRatedProvider with ChangeNotifier {
  var topRated = TopRated();
  var results;

  Future<void> getTopRated() async {
    final responce = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/top_rated?api_key=d6059b1e6561f2f6cc633a68a0416703'));
    final pomov1 = await json.decode(responce.body);
    final res = topRatedFromJson(responce.body);
    topRated = res;
    results = topRated.results;

    notifyListeners();
  }
}
