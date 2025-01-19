class Movie {
  final int id;
  final String title;
  final String posterPath;
  final double voteAverage;
  final String overview;
  final List<String> genres;

  Movie({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.voteAverage,
    required this.overview,
    required this.genres,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    List<String> parsedGenres = [];
    if (json['genres'] is List) {
      parsedGenres = (json['genres'] as List).map((genre) {
        if (genre is Map && genre['name'] != null) {
          return genre['name'] as String;
        }
        return '';
      }).toList();
    }

    return Movie(
      id: json['id'],
      title: json['title'],
      posterPath: json['poster_path'] ?? '',
      voteAverage: (json['vote_average'] ?? 0).toDouble(),
      overview: json['overview'] ?? '',
      genres: parsedGenres,
    );
  }
}
