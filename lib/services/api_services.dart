import 'dart:convert';
import 'package:flutterchallenge/model/movie_model.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  static const String baseUrl = "https://movies-api.nomadcoders.workers.dev";
  static const String nowPlaying = "now-playing";
  static const String comingSoon = "coming-soon";
  static const String popular = "popular";

  static Future<List<MovieModel>> getNowPlayingMovie() async {
    List<MovieModel> nowPlayingInstances = [];
    final nowPlayingurl = Uri.parse('$baseUrl/$nowPlaying');
    final nowPlayingresponse = await http.get(nowPlayingurl);

    if (nowPlayingresponse.statusCode == 200) {
      final Map<String, dynamic> decodedData =
          jsonDecode(nowPlayingresponse.body);
      final List<dynamic> nowPlayingmovies = decodedData['results']; // 리스트 추출

      for (var movie in nowPlayingmovies) {
        nowPlayingInstances.add(MovieModel.fromJson(movie));
      }
      return nowPlayingInstances;
    }
    throw Error();
  }

  static Future<List<MovieModel>> getComingSoonMovie() async {
    List<MovieModel> comingSoonInstances = [];
    final comingSoonurl = Uri.parse('$baseUrl/$comingSoon');
    final comingSoonresponse = await http.get(comingSoonurl);

    if (comingSoonresponse.statusCode == 200) {
      final Map<String, dynamic> decodedData =
          jsonDecode(comingSoonresponse.body);
      final List<dynamic> comingSoonmovies = decodedData['results']; // 리스트 추출

      for (var movie in comingSoonmovies) {
        comingSoonInstances.add(MovieModel.fromJson(movie));
      }
      return comingSoonInstances;
    }
    throw Error();
  }

  static Future<List<MovieModel>> getPopularMovie() async {
    List<MovieModel> popularInstances = [];
    final popularurl = Uri.parse('$baseUrl/$popular');
    final popularresponse = await http.get(popularurl);

    if (popularresponse.statusCode == 200) {
      final Map<String, dynamic> decodedData = jsonDecode(popularresponse.body);
      final List<dynamic> popularmovies = decodedData['results']; // 리스트 추출

      for (var movie in popularmovies) {
        popularInstances.add(MovieModel.fromJson(movie));
      }
      return popularInstances;
    }
    throw Error();
  }
}
