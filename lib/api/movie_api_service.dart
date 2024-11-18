import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/api_key.dart';

class MovieApiService {
  static const String baseUrl = 'https://api.themoviedb.org/3';

  // Fetch movies by category like "now_playing", "popular", etc.
  Future<List<dynamic>> fetchMovies(String category, int page) async {
    final response = await http.get(
      Uri.parse(
          '$baseUrl/movie/$category?api_key=$apiKey&language=en-US&page=$page'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['results'];
    } else {
      throw Exception('Failed to load movies');
    }
  }

  // Search movies by query
  Future<List<dynamic>> searchMovies(String query, int page) async {
    final response = await http.get(
      Uri.parse(
          '$baseUrl/search/movie?api_key=$apiKey&language=en-US&query=$query&page=$page'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['results'];
    } else {
      throw Exception('Failed to search movies');
    }
  }

  Future<Map<String, dynamic>> fetchMovieDetails(int movieId) async {
    final response = await http.get(
      Uri.parse(
          '$baseUrl/movie/$movieId?api_key=$apiKey&language=en-US&append_to_response=credits,reviews,similar'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load movie details');
    }
  }
}
