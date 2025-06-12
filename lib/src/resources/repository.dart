import 'dart:async';
import 'package:flutter_blocrx_project/src/models/trailer_model.dart';
import 'movie_api_provider.dart';
import '../models/item_model.dart';

class Repository {
  final MovieApiProvider moviesApiProvider;

  Repository(this.moviesApiProvider);

  Future<ItemModel> fetchAllMovies() => moviesApiProvider.fetchMovieList();
  Future<TrailerModel> fetchTrailers(int movieId) => moviesApiProvider.fetchTrailer(movieId);
}
