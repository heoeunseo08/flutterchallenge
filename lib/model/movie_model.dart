class MovieModel {
  final dynamic adult,
      backdropPath,
      genreIds,
      id,
      originalLanguage,
      originalTitle,
      overview,
      popularity,
      posterPath,
      releaseDate,
      title,
      video,
      voteAverage,
      voteCount;

  MovieModel.fromJson(Map<String, dynamic> json)
      : adult = json['adult'],
        backdropPath = json['backdrop_path'],
        genreIds = json['genre_ids'],
        id = json['id'],
        originalLanguage = json['original_language'],
        originalTitle = json['originalTitle'],
        overview = json['overview'],
        popularity = json['popularity'],
        posterPath = json['posterPath'],
        releaseDate = json['releaseDate'],
        title = json['title'],
        video = json['video'],
        voteAverage = json['voteAverage'],
        voteCount = json['voteCount'];
}
/*{
      "adult": false,
      "backdrop_path": "/rOMLLMGgDgGG6XeT3P8sUdUb8nl.jpg",
      "genre_ids": [28, 53, 80],
      "id": 1126166,
      "original_language": "en",
      "original_title": "Flight Risk",
      "overview": "A U.S. Marshal escorts a government witness to trial after he's accused of getting involved with a mob boss, only to discover that the pilot who is transporting them is also a hitman sent to assassinate the informant. After they subdue him, they're forced to fly together after discovering that there are others attempting to eliminate them.",
      "popularity": 1579.252,
      "poster_path": "/4cR3hImKd78dSs652PAkSAyJ5Cx.jpg",
      "release_date": "2025-01-22",
      "title": "Flight Risk",
      "video": false,
      "vote_average": 5.7,
      "vote_count": 173
    },*/
