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
    print("▶︎ MovieApiProvider: fetchMovieList()");
    final uri = Uri.parse('$_baseUrl/popular?api_key=$_apiKey');
    try {
      final response = await client.get(uri);
      print("▶︎ MovieApiProvider: HTTP ${response.statusCode}");
      if (response.statusCode == 200) {
        print("▶︎ MovieApiProvider: got 200 OK, parsing JSON");
        return ItemModel.fromJson(json.decode(response.body));
      } else {
        print("‼︎ MovieApiProvider: non-200 status, body = ${response.body}");
        throw Exception('HTTP ${response.statusCode}');
      }
    } catch (e) {
      print("‼︎ MovieApiProvider: caught exception → $e");
      rethrow;
    }
  }

  Future<TrailerModel> fetchTrailer(int movieId) async {
    print("▶︎ MovieApiProvider: fetchTrailer($movieId)");
    final uri = Uri.parse('$_baseUrl/$movieId/videos?api_key=$_apiKey');
    try {
      final response = await client.get(uri);
      print("▶︎ MovieApiProvider: HTTP ${response.statusCode} for trailer");
      if (response.statusCode == 200) {
        print("▶︎ MovieApiProvider: got 200 OK for trailer, parsing JSON");
        return TrailerModel.fromJson(jsonDecode(response.body));
      } else {
        print("‼︎ MovieApiProvider: non-200 status for trailer, body = ${response.body}");
        throw Exception('HTTP ${response.statusCode}');
      }
    } catch (e) {
      print("‼︎ MovieApiProvider: caught exception in fetchTrailer → $e");
      rethrow;
    }
  }
}
