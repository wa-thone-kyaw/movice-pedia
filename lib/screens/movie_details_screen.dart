import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/screens/video_play_screen.dart';
import 'package:provider/provider.dart';
import '../providers/movie_provider.dart';
import '../widgets/cast_list.dart';
import '../widgets/review_list.dart';
import '../widgets/movie_list.dart';
import 'package:flutter/scheduler.dart'; // Add this import

class MovieDetailsScreen extends StatefulWidget {
  final int movieId;

  const MovieDetailsScreen({Key? key, required this.movieId}) : super(key: key);

  @override
  _MovieDetailsScreenState createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  @override
  void initState() {
    super.initState();
    // Use addPostFrameCallback to delay the fetch operation
    SchedulerBinding.instance.addPostFrameCallback((_) {
      // Fetch movie details on screen load after the first frame
      Provider.of<MovieProvider>(context, listen: false)
          .fetchMovieDetails(widget.movieId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Details'),
      ),
      body: movieProvider.isMovieDetailsLoading
          ? const Center(child: CircularProgressIndicator())
          : movieProvider.movieDetails == null
              ? const Center(child: Text('Failed to load movie details'))
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Display movie backdrop image
                      if (movieProvider.movieDetails!.backdropPath.isNotEmpty)
                        Image.network(
                          'https://image.tmdb.org/t/p/w500${movieProvider.movieDetails!.backdropPath}',
                        ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          movieProvider.movieDetails!.title,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(movieProvider.movieDetails!.overview),
                      ),
                      // Check if videoId exists and show Play button
                      if (movieProvider.movieDetails!.videoId != null &&
                          movieProvider.movieDetails!.videoId!.isNotEmpty)
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              // Navigate to the video player screen
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => VideoPlayerScreen(
                                    videoId:
                                        movieProvider.movieDetails!.videoId!,
                                  ),
                                ),
                              );
                            },
                            child: const Text('Play Movie'),
                          ),
                        ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Cast',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      CastList(cast: movieProvider.movieDetails?.cast ?? []),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Reviews',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ReviewList(
                          reviews: movieProvider.movieDetails?.reviews ?? []),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Similar Movies',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      MovieList(
                        movies: movieProvider.movieDetails?.similarMovies
                                .map((movieJson) => Movie.fromJson(movieJson))
                                .toList() ??
                            [],
                      ),
                    ],
                  ),
                ),
    );
  }
}
