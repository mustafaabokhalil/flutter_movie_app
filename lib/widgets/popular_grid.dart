import 'package:flutter/material.dart';
import 'package:movieapp/provider/popular_provider.dart';
import 'package:movieapp/widgets/popular_item.dart';
import 'package:provider/provider.dart';

class PopularGride extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<PopularProvider>(context).getMovie();
    final poprovider = Provider.of<PopularProvider>(context);
    final result = poprovider.resul;
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: result!.length,
      itemBuilder: (ctx, i) => PoularItem(index: i),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
