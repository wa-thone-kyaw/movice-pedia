import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/watchlist_provider.dart';
import '../widgets/movie_list.dart';

class WatchlistScreen extends StatelessWidget {
  const WatchlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final watchlistProvider = Provider.of<WatchlistProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist'),
      ),
      body: watchlistProvider.watchlist.isEmpty
          ? const Center(child: Text('Your watchlist is empty.'))
          : MovieList(movies: watchlistProvider.watchlist),
    );
  }
}
