import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:provider/provider.dart';
import '../providers/movie_provider.dart';
import '../widgets/movie_list.dart';

class SimilarMoviesScreen extends StatelessWidget {
  final int movieId;

  const SimilarMoviesScreen({Key? key, required this.movieId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);

    if (movieProvider.movieDetails == null) {
      movieProvider.fetchMovieDetails(movieId);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Similar Movies'),
      ),
      body: movieProvider.isMovieDetailsLoading
          ? const Center(child: CircularProgressIndicator())
          : movieProvider.movieDetails == null
              ? const Center(child: Text('Failed to load similar movies'))
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Similar Movies',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                      ),
                      MovieList(
                          movies: movieProvider.movieDetails!.similarMovies
                              .cast<Movie>()),
                    ],
                  ),
                ),
    );
  }
}
