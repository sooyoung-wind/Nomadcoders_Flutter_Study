import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie.dart';

class ApiService {
  static const String baseUrl = "https://movies-api.nomadcoders.workers.dev";

  // 인기 많은 영화
  static Future<List<Movie>> getPopularMovies() async {
    final url = Uri.parse('$baseUrl/popular');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> results = data['results'];
      return results.map((item) => Movie.fromJson(item)).toList();
    } else {
      throw Error();
    }
  }

  // 현재 상영 중 영화
  static Future<List<Movie>> getNowPlayingMovies() async {
    final url = Uri.parse('$baseUrl/now-playing');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> results = data['results'];
      return results.map((item) => Movie.fromJson(item)).toList();
    } else {
      throw Error();
    }
  }

  // 곧 개봉할 영화
  static Future<List<Movie>> getComingSoonMovies() async {
    final url = Uri.parse('$baseUrl/coming-soon');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> results = data['results'];
      return results.map((item) => Movie.fromJson(item)).toList();
    } else {
      throw Error();
    }
  }

  // 영화 상세 정보
  // 예: https://movies-api.nomadcoders.workers.dev/movie?id=1
  static Future<Movie> getMovieDetail(int movieId) async {
    final url = Uri.parse('$baseUrl/movie?id=$movieId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Movie.fromJson(data);
    } else {
      throw Error();
    }
  }
}
