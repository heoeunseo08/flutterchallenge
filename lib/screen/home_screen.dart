import 'package:flutter/material.dart';
import 'package:flutterchallenge/model/movie_model.dart';
import 'package:flutterchallenge/services/api_services.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<Future<List<MovieModel>>> movies = [
    ApiServices.getPopularMovie(),
    ApiServices.getNowPlayingMovie(),
    ApiServices.getComingSoonMovie(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: FutureBuilder(
        future: Future.wait(movies),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            final popularMovies = snapshot.data![0];
            final nowPlayingMovies = snapshot.data![1];
            final comingSoonMovies = snapshot.data![2];

            return Column(
              children: [
                const SizedBox(height: 40),
                Expanded(
                  child: makeLists(
                    popularMovies,
                    nowPlayingMovies,
                    comingSoonMovies,
                  ),
                ),
              ],
            );
          }

          return const Center(child: Text("No data available"));
        },
      ),
    );
  }

  Widget makeLists(List<MovieModel> popularMovies,
      List<MovieModel> nowPlayingMovies, List<MovieModel> comingSoonMovies) {
    return ListView(
      padding: const EdgeInsets.all(16),
      shrinkWrap: true,
      children: [
        _buildMovieSection("Popular", popularMovies),
        const SizedBox(height: 20),
        _buildMovieSection("Now Playing", nowPlayingMovies),
        const SizedBox(height: 20),
        _buildMovieSection("Coming Soon", comingSoonMovies),
      ],
    );
  }

  Widget _buildMovieSection(String title, List<MovieModel> movies) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 200,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (context, index) {
              var movie = movies[index];

              // ✅ TMDB API의 이미지 경로 처리
              String baseUrl = "https://image.tmdb.org/t/p/w500";
              String imageUrl = "$baseUrl${movie.backdropPath}";

              return Container(
                width: 120,
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10,
                            offset: Offset(10, 10),
                            // ignore: deprecated_member_use
                            color: Colors.black.withOpacity(0.3),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          imageUrl,
                          height: 150,
                          width: 140,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              "assets/images/no_image.png",
                              height: 130,
                              width: 120,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      movie.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 17),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(width: 10),
          ),
        ),
      ],
    );
  }
}
