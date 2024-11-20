import 'package:flutter/foundation.dart';
import '../api/movie_api_service.dart';
import '../models/movie_model.dart';
import '../models/movie_details_model.dart';

class MovieProvider with ChangeNotifier {
  final MovieApiService _apiService = MovieApiService();

  List<Movie> nowPlayingMovies = [];
  List<Movie> popularMovies = [];
  List<Movie> topRatedMovies = [];
  bool isLoading = false;

  // Pagination
  int nowPlayingPage = 1;
  int popularPage = 1;
  int topRatedPage = 1;

  // Movie details
  MovieDetails? movieDetails;
  bool isMovieDetailsLoading = false;

  Future<void> fetchMovies(String category) async {
    if (isLoading) return;
    isLoading = true;
    notifyListeners();

    try {
      final int page = (category == 'now_playing')
          ? nowPlayingPage
          : (category == 'popular')
              ? popularPage
              : topRatedPage;

      final movies = await _apiService.fetchMovies(category, page);

      final movieList = movies.map((movie) => Movie.fromJson(movie)).toList();
      switch (category) {
        case 'now_playing':
          nowPlayingMovies.addAll(movieList);
          nowPlayingPage++;
          break;
        case 'popular':
          popularMovies.addAll(movieList);
          popularPage++;
          break;
        case 'top_rated':
          topRatedMovies.addAll(movieList);
          topRatedPage++;
          break;
      }
    } catch (error) {
      debugPrint('Error fetching $category movies: $error');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Fetch Movie Details
  Future<void> fetchMovieDetails(int movieId) async {
    if (isMovieDetailsLoading) return;
    isMovieDetailsLoading = true;
    notifyListeners();

    try {
      final data = await _apiService.fetchMovieDetails(movieId);
      movieDetails = MovieDetails.fromJson(data);
    } catch (error) {
      debugPrint('Error fetching movie details: $error');
    } finally {
      isMovieDetailsLoading = false;
      notifyListeners();
    }
  }
}
