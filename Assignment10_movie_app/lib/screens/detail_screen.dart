import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/movie.dart';

class DetailScreen extends StatefulWidget {
  final int movieId;

  const DetailScreen({Key? key, required this.movieId}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<Movie> movieDetail;

  @override
  void initState() {
    super.initState();
    movieDetail = ApiService.getMovieDetail(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movie Detail"),
      ),
      body: FutureBuilder<Movie>(
        future: movieDetail,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("에러가 발생했어요!"));
          } else if (!snapshot.hasData) {
            return const Center(child: Text("영화 정보를 찾을 수 없어요."));
          } else {
            final movie = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 영화 포스터
                  Image.network(
                    "https://image.tmdb.org/t/p/w500${movie.posterPath}",
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 16),
                  // 영화 제목
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      movie.title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // 평점
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text("평점: ${movie.voteAverage}"),
                  ),
                  const SizedBox(height: 8),
                  // 장르
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text("장르: ${movie.genres.join(', ')}"),
                  ),
                  const SizedBox(height: 16),
                  // 개요
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "Storyline",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(movie.overview),
                  ),
                  const SizedBox(height: 16),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("티켓 구매!")),
                        );
                      },
                      child: const Text("Buy ticket"),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
