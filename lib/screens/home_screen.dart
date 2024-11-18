import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/movie_provider.dart';
import '../widgets/movie_list.dart';
import 'search_screen.dart';
import 'watchlist_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late MovieProvider movieProvider;

  @override
  void initState() {
    super.initState();
    movieProvider = Provider.of<MovieProvider>(context, listen: false);

    // Fetch initial data
    movieProvider.fetchMovies('now_playing');
    movieProvider.fetchMovies('popular');
    movieProvider.fetchMovies('top_rated');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movice Pedia'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SearchScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.bookmark),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const WatchlistScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Now Playing',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            Consumer<MovieProvider>(
              builder: (context, provider, _) {
                return MovieList(
                  movies: provider.nowPlayingMovies,
                  onEndReached: () => provider.fetchMovies('now_playing'),
                );
              },
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Popular Movies',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            Consumer<MovieProvider>(
              builder: (context, provider, _) {
                return MovieList(
                  movies: provider.popularMovies,
                  onEndReached: () => provider.fetchMovies('popular'),
                );
              },
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Top Rated Movies',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            Consumer<MovieProvider>(
              builder: (context, provider, _) {
                return MovieList(
                  movies: provider.topRatedMovies,
                  onEndReached: () => provider.fetchMovies('top_rated'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
