import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/provider/popular_provider.dart';
import 'package:movieapp/provider/top_rated_provider.dart';
import 'package:movieapp/screens/details_screen.dart';
import 'package:movieapp/screens/top_rated_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class TopRatedItem extends StatelessWidget {
  final index;

  TopRatedItem({this.index});

  @override
  Widget build(BuildContext context) {
    final poprovider = Provider.of<TopRatedProvider>(context);
    final result = poprovider.results;
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TopRatedDetails(
                          index: this.index,
                        )));
          },
          child: Image.network(
            'https://www.themoviedb.org/t/p/w600_and_h900_bestv2/' +
                poprovider.results![index].posterPath.toString(),
            fit: BoxFit.cover,
            width: 150,
            height: 150,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black,
          title: Text(
            poprovider.results![index].originalTitle.toString(),
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          trailing: Container(
            width: 65,
            height: 30,
            child: Card(
              color: Colors.grey.withOpacity(0.4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.yellowAccent,
                    size: 20,
                  ),
                  Text(
                    poprovider.results![this.index].voteAverage.toString(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                ],
              ),
            ),
          ),
          subtitle: Container(
            width: 50,
            child: Text(
              '(' +
                  poprovider.results![index].releaseDate!.year.toString() +
                  ')',
              style: const TextStyle(color: Colors.grey),
            ),
          ),
        ),
      ),
    );
  }
}
