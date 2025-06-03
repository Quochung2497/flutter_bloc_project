class ItemModel {
  final int page;
  final int totalResults;
  final int totalPages;
  final List<Result> results;

  ItemModel({
    required this.page,
    required this.totalResults,
    required this.totalPages,
    required this.results,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    final rawResults = json['results'] as List<dynamic>;
    final mappedResults = rawResults
        .map((item) => Result(item as Map<String, dynamic>))
        .toList();
    return ItemModel(
      page: json['page'] as int,
      totalResults: json['total_results'] as int,
      totalPages: json['total_pages'] as int,
      results: mappedResults,
    );
  }
}

class Result {
  final int voteCount;
  final int id;
  final bool video;
  final num voteAverage;
  final String title;
  final double popularity;
  final String posterPath;
  final String originalLanguage;
  final String originalTitle;
  final List<int> genreIds;
  final String backdropPath;
  final bool adult;
  final String overview;
  final String releaseDate;

  Result(Map<String, dynamic> data)
      : voteCount = data['vote_count'] as int,
        id = data['id'] as int,
        video = data['video'] as bool,
        voteAverage = data['vote_average'] as num,
        title = data['title'] as String,
        popularity = (data['popularity'] as num).toDouble(),
        posterPath = data['poster_path'] as String,
        originalLanguage = data['original_language'] as String,
        originalTitle = data['original_title'] as String,
        genreIds = List<int>.from(data['genre_ids'] as List<dynamic>),
        backdropPath = data['backdrop_path'] as String? ?? '',
        adult = data['adult'] as bool,
        overview = data['overview'] as String,
        releaseDate = data['release_date'] as String;
}