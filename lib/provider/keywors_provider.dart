import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movieapp/models/keywords.dart';
import 'package:movieapp/models/popular.dart';
import 'package:http/http.dart' as http;

import 'package:movieapp/models/videos.dart';

class KeyWordsProvider with ChangeNotifier {
  var popmovie = PopularMovie();
  KeyWords _keyWords = KeyWords();
  var key;
  var name;
  Future<void> getKeyWords(int? index) async {
    final responce = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/${index}/keywords?api_key=d6059b1e6561f2f6cc633a68a0416703'));
    final pomov1 = await json.decode(responce.body);

    final res = keyWordsFromJson(responce.body);
    _keyWords = res;
    // ignore: avoid_function_literals_in_foreach_calls
    if (_keyWords.id == index) {
      {
        name = _keyWords.keywords!.map((e) => e.name);
        notifyListeners();
      }
    }

    /* key = _keyWords.keywords!.length;
    notifyListeners();*/

    //print(res.results!.map((e) => e.key));
  }
}
