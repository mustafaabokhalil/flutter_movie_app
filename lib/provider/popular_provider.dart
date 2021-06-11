import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movieapp/models/popular.dart';
import 'package:http/http.dart' as http;

class PopularProvider with ChangeNotifier {
  PopularMovie populars = PopularMovie();
  List<dynamic>? resul;

  Future<void> getMovie() async {
    final responce = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/popular?api_key=d6059b1e6561f2f6cc633a68a0416703'));
    final pomov1 = await json.decode(responce.body);
    final res = popularMovieFromJson(responce.body);
    populars = res;
    resul = populars.results;
    notifyListeners();
  }
}
