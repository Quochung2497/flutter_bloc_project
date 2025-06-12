import 'dart:async';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import '../models/item_model.dart';
import '../models/trailer_model.dart';

class MovieApiProvider {
  final Client client;
  final _apiKey = 'a099e26eedb7f31840470a46dc047a17';
  final _baseUrl = "http://api.themoviedb.org/3/movie";

  MovieApiProvider(this.client);

  Future<ItemModel> fetchMovieList() async {
    final uri = Uri.parse('$_baseUrl/popular?api_key=$_apiKey');
    try {
      final response = await client.get(uri);
      if (response.statusCode == 200) {
        return ItemModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('HTTP ${response.statusCode}');
      }
    } catch (e) {
      print("‼︎ MovieApiProvider: caught exception → $e");
      rethrow;
    }
  }

  Future<TrailerModel> fetchTrailer(int movieId) async {
    final uri = Uri.parse('$_baseUrl/$movieId/videos?api_key=$_apiKey');
    try {
      final response = await client.get(uri);
      if (response.statusCode == 200) {
        return TrailerModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('HTTP ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
