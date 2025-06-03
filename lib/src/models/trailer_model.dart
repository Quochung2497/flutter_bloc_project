class TrailerModel {
  final int id;
  final List<Result> results;

  TrailerModel({
    required this.id,
    required this.results,
  });

  factory TrailerModel.fromJson(Map<String, dynamic> parsedJson) {
    final rawResults = parsedJson['results'] as List<dynamic>;
    final mappedResults = rawResults
        .map((item) => Result.fromJson(item as Map<String, dynamic>))
        .toList();

    return TrailerModel(
      id: parsedJson['id'] as int,
      results: mappedResults,
    );
  }
}

class Result {
  final String id;
  final String iso6391;
  final String iso31661;
  final String key;
  final String name;
  final String site;
  final int size;
  final String type;

  Result({
    required this.id,
    required this.iso6391,
    required this.iso31661,
    required this.key,
    required this.name,
    required this.site,
    required this.size,
    required this.type,
  });

  factory Result.fromJson(Map<String, dynamic> data) {
    return Result(
      id: data['id'] as String,
      iso6391: data['iso_639_1'] as String,
      iso31661: data['iso_3166_1'] as String,
      key: data['key'] as String,
      name: data['name'] as String,
      site: data['site'] as String,
      size: (data['size'] as num).toInt(),
      type: data['type'] as String,
    );
  }
}
