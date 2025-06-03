import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blocrx_project/src/blocs/movies_bloc.dart';

import '../models/item_model.dart';

class MovieList extends StatelessWidget {
  const MovieList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Popular Movies')),
      body: BlocBuilder<MoviesBloc, ItemModel?>(
        builder: (context, state) {
          if (state == null) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = state;
          return GridView.builder(
            itemCount: data.results.length,
            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (context, index) {
              final movie = data.results[index];
              return GridTile(
                child: InkResponse(
                  enableFeedback: true,
                  child: Image.network(
                    'https://image.tmdb.org/t/p/w185${movie.posterPath}',
                    fit: BoxFit.cover,
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      'movieDetail',
                      arguments: movie,
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}