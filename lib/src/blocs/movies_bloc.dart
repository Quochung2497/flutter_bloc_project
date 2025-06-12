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
    try {
      final ItemModel movies = await _repository.fetchAllMovies();
      emit(movies);
    } catch (_) {
      emit(null);
    }
  }
}
