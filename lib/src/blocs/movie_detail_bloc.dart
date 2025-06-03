import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import '../models/trailer_model.dart';
import '../resources/repository.dart';

class MovieDetailBloc extends Cubit<Future<TrailerModel>> {
  final Repository _repository;

  MovieDetailBloc(this._repository)
      : super(Future<TrailerModel>.value(
    TrailerModel(id: 0, results: <Result>[]),
  ));

  void fetchTrailersById(int movieId) {
    final future = _repository.fetchTrailers(movieId);
    emit(future);
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
