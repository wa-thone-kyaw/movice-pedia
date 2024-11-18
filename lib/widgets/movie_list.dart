import 'package:flutter/material.dart';
import '../models/movie_model.dart';
import '../screens/movie_details_screen.dart';

class MovieList extends StatelessWidget {
  final List<Movie> movies;
  final VoidCallback? onEndReached;

  const MovieList({Key? key, required this.movies, this.onEndReached})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height *
          0.6, // Adjust the height as needed
      child: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.pixels >=
                  scrollInfo.metrics.maxScrollExtent - 100 &&
              onEndReached != null) {
            onEndReached!();
          }
          return false;
        },
        child: ListView.builder(
          itemCount: movies.length + 1,
          itemBuilder: (context, index) {
            if (index == movies.length) {
              return const Center(child: CircularProgressIndicator());
            }
            final movie = movies[index];
            return ListTile(
              leading: Image.network(
                'https://image.tmdb.org/t/p/w200${movie.posterPath}',
                fit: BoxFit.cover,
                width: 50,
              ),
              title: Text(movie.title),
              subtitle: Text('Rating: ${movie.rating.toString()}'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => MovieDetailsScreen(movieId: movie.id)),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
