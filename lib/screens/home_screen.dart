import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/movie_provider.dart';
import '../widgets/movie_list.dart';
import '../widgets/bottom_navigation.dart';
import 'search_screen.dart';
import 'watchlist_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late MovieProvider movieProvider;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    movieProvider = Provider.of<MovieProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      movieProvider.fetchMovies('now_playing');
      movieProvider.fetchMovies('popular');
      movieProvider.fetchMovies('top_rated');
    });
  }

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildContent() {
    switch (_selectedIndex) {
      case 1:
        return const SearchScreen();
      case 2:
        return const WatchlistScreen();
      case 3:
        return const Center(
          child: Text(
            'Download Screen',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        );
      case 4:
        return const Center(
          child: Text(
            'Profile Screen',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        );
      case 0:
      default:
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Now Playing',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              Consumer<MovieProvider>(builder: (context, provider, _) {
                return MovieList(
                  movies: provider.nowPlayingMovies,
                  onEndReached: () => provider.fetchMovies('now_playing'),
                );
              }),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Popular Movies',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              Consumer<MovieProvider>(builder: (context, provider, _) {
                return MovieList(
                  movies: provider.popularMovies,
                  onEndReached: () => provider.fetchMovies('popular'),
                );
              }),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Top Rated Movies',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              Consumer<MovieProvider>(builder: (context, provider, _) {
                return MovieList(
                  movies: provider.topRatedMovies,
                  onEndReached: () => provider.fetchMovies('top_rated'),
                );
              }),
            ],
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.pink],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Text(
          'Movie Pedia',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
      ),
      body: _buildContent(),
      bottomNavigationBar: BottomNavigation(
        currentIndex: _selectedIndex,
        onTabSelected: _onTabSelected,
      ),
    );
  }
}
