import 'dart:async';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import '../models/movie_model.dart';

class MovieApiProvider {
  String url = 'http://api.douban.com/v2/movie/top250?start={0}&count={1}';
  Client client = Client();

  // 获取电影数据
  Future<MovieModel> fatchMovieList(int start, int count) async {
    String newUrl = url
        .replaceFirst('{0}', start.toString())
        .replaceFirst('{1}', count.toString());
    final response = await client.get(newUrl);
    if (response.statusCode == 200) {
      return MovieModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to fatch movie');
    }
  }
}
