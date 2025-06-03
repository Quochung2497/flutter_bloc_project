import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'ui/movie_list.dart';
import 'ui/movie_detail.dart';
import 'models/item_model.dart';
import 'resources/repository.dart';
import 'blocs/movie_detail_bloc.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        if (settings.name == 'movieDetail') {
          final result = settings.arguments as Result;

          return MaterialPageRoute(
            builder: (context) {
              return BlocProvider<MovieDetailBloc>(
                create: (ctx) {
                  final bloc = MovieDetailBloc(ctx.read<Repository>());
                  bloc.fetchTrailersById(result.id);
                  return bloc;
                },
                child: MovieDetail(
                  title:       result.title,
                  posterUrl:   result.backdropPath,
                  description: result.overview,
                  releaseDate: result.releaseDate,
                  voteAverage: result.voteAverage.toString(),
                  movieId:     result.id,
                ),
              );
            },
          );
        }

        // Default route ('/'): show MovieList, which will grab the top‐level MoviesBloc from context
        return MaterialPageRoute(
          builder: (context) {
            return const MovieList();
          },
        );
      },
    );
  }
}