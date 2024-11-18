import 'package:flutter/foundation.dart';
import '../models/movie_model.dart';

class WatchlistProvider with ChangeNotifier {
  final List<Movie> _watchlist = [];

  List<Movie> get watchlist => _watchlist;

  void addToWatchlist(Movie movie) {
    if (!_watchlist.any((m) => m.id == movie.id)) {
      _watchlist.add(movie);
      notifyListeners();
    }
  }

  void removeFromWatchlist(int movieId) {
    _watchlist.removeWhere((movie) => movie.id == movieId);
    notifyListeners();
  }

  bool isInWatchlist(int movieId) {
    return _watchlist.any((movie) => movie.id == movieId);
  }
}
