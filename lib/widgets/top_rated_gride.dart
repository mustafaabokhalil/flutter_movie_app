import 'package:flutter/material.dart';
import 'package:movieapp/provider/popular_provider.dart';
import 'package:movieapp/provider/top_rated_provider.dart';
import 'package:movieapp/widgets/popular_item.dart';
import 'package:movieapp/widgets/top_rated_item.dart';
import 'package:provider/provider.dart';

class TopRatedGride extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final poprovider = Provider.of<TopRatedProvider>(context);
    final result = poprovider.results;
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: result!.length,
      itemBuilder: (ctx, i) => TopRatedItem(index: i),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
