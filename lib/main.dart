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
          create: (_) => http.Client(),
        ),
        RepositoryProvider<MovieApiProvider>(
          create: (ctx) => MovieApiProvider(ctx.read<http.Client>()),
        ),
        RepositoryProvider<Repository>(
          create: (ctx) => Repository(ctx.read<MovieApiProvider>()),
        ),
      ],
      child: BlocProvider<MoviesBloc>(
        create: (ctx) => MoviesBloc(ctx.read<Repository>()),
        child: const App(),
      ),
    ),
  );
}