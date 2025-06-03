import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/item_model.dart';
import '../resources/repository.dart';

class MoviesBloc extends Cubit<ItemModel?> {
  final Repository _repository;

  MoviesBloc(this._repository) : super(null) {
    _loadMovies();
  }

  Future<void> _loadMovies() async {
    print("▶︎ MoviesCubit: _loadMovies() called");
    try {
      final ItemModel movies = await _repository.fetchAllMovies();
      print("▶︎ MoviesCubit: fetched ${movies.results.length} movies");
      emit(movies);
    } catch (_) {
      print("‼︎ MoviesCubit: fetch failed → emit(null)");
      emit(null);
    }
  }
}
