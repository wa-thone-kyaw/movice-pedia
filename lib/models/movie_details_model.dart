import 'package:movie_app/models/movie_model.dart';

class MovieDetails {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final String backdropPath;
  final double rating;
  final List<dynamic> genres;
  final List<dynamic> cast;
  final List<dynamic> reviews;
  final List<dynamic> similarMovies;
  final String? videoId;

  MovieDetails({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.rating,
    required this.genres,
    required this.cast,
    required this.reviews,
    required this.similarMovies,
    this.videoId,
  });

  factory MovieDetails.fromJson(Map<String, dynamic> json) {
    return MovieDetails(
      id: json['id'],
      title: json['title'] ?? 'Untitled',
      overview: json['overview'] ?? '',
      posterPath: json['poster_path'] ?? '',
      backdropPath: json['backdrop_path'] ?? '',
      rating: (json['vote_average'] ?? 0).toDouble(),
      genres: json['genres'] ?? [],
      cast: json['credits']?['cast'] ?? [],
      reviews: json['reviews']?['results'] ?? [],
      similarMovies: json['similar']?['results'] ?? [],
      videoId: (json['videos'] != null &&
              json['videos']['results'] != null &&
              json['videos']['results'].isNotEmpty)
          ? json['videos']['results'][0]['key']
          : null,
    );
  }
}
