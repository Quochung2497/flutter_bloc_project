import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'src/blocs/movies_bloc.dart';
import 'package:http/http.dart' as http;
import 'src/resources/movie_api_provider.dart';
import 'src/resources/repository.dart';
import 'src/app.dart';

void main() {
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<http.Client>(
          create: (_) {
            print("▶︎ main.dart: creating HTTP Client");
            return http.Client();
          },
        ),
        RepositoryProvider<MovieApiProvider>(
          create: (ctx) {
            print("▶︎ main.dart: creating MovieApiProvider");
            return MovieApiProvider(ctx.read<http.Client>());
          },
        ),
        RepositoryProvider<Repository>(
          create: (ctx) {
            print("▶︎ main.dart: creating Repository");
            return Repository(ctx.read<MovieApiProvider>());
          },
        ),
      ],
      child: BlocProvider<MoviesBloc>(
        create: (ctx) {
          print("▶︎ main.dart: creating MoviesCubit");
          return MoviesBloc(ctx.read<Repository>());
        },
        child: const App(),
      ),
    ),
  );
}