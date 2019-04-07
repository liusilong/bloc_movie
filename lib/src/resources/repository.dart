import 'dart:async';
import '../models/movie_model.dart';
import './movie_api_provider.dart';

class Repository {
  final moviesApiProvider = MovieApiProvider();
  Future<MovieModel> fetchAllMovies(int start, int count) async {
    return await moviesApiProvider.fatchMovieList(start, count);
  }
}

Repository repository = Repository();
