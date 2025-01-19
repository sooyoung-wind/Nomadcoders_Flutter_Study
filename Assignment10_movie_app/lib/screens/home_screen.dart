import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/movie.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Movie>> popularMovies;
  late Future<List<Movie>> nowPlayingMovies;
  late Future<List<Movie>> comingSoonMovies;

  @override
  void initState() {
    super.initState();
    popularMovies = ApiService.getPopularMovies();
    nowPlayingMovies = ApiService.getNowPlayingMovies();
    comingSoonMovies = ApiService.getComingSoonMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movie App"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            // 인기 많은 영화
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Popular Movies",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            FutureBuilder<List<Movie>>(
              future: popularMovies,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text("에러가 발생했어요!"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("데이터가 없어요!"));
                } else {
                  final movies = snapshot.data!;
                  return SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        final movie = movies[index];
                        return GestureDetector(
                          onTap: () {
                            // 탭하면 상세화면으로 이동
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailScreen(
                                  movieId: movie.id,
                                ),
                              ),
                            );
                          },
                          child: SizedBox(
                            width: 120,
                            child: Column(
                              children: [
                                Expanded(
                                  child: Image.network(
                                    // 이미지 전체 URL = https://image.tmdb.org/t/p/w500 + posterPath
                                    "https://image.tmdb.org/t/p/w500${movie.posterPath}",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Text(
                                  movie.title,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 20),
            // 현재 상영 중 영화
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Now in Cinemas",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            FutureBuilder<List<Movie>>(
              future: nowPlayingMovies,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text("에러가 발생했어요!"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("데이터가 없어요!"));
                } else {
                  final movies = snapshot.data!;
                  return SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        final movie = movies[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailScreen(
                                  movieId: movie.id,
                                ),
                              ),
                            );
                          },
                          child: SizedBox(
                            width: 120,
                            child: Column(
                              children: [
                                Expanded(
                                  child: Image.network(
                                    "https://image.tmdb.org/t/p/w500${movie.posterPath}",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Text(
                                  movie.title,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 20),
            // 곧 개봉할 영화
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Coming soon",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            FutureBuilder<List<Movie>>(
              future: comingSoonMovies,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text("에러가 발생했어요!"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("데이터가 없어요!"));
                } else {
                  final movies = snapshot.data!;
                  return SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        final movie = movies[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailScreen(
                                  movieId: movie.id,
                                ),
                              ),
                            );
                          },
                          child: SizedBox(
                            width: 120,
                            child: Column(
                              children: [
                                Expanded(
                                  child: Image.network(
                                    "https://image.tmdb.org/t/p/w500${movie.posterPath}",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Text(
                                  movie.title,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
