import 'dart:convert';

class Movie {
    Movie({
        required this.adult,
        this.backdropPath,
        required this.genreIds,
        required this.id,
        required this.originalLanguage,
        required this.originalTitle,
        required this.overview,
        required this.popularity,
        this.posterPath,
        this.releaseDate,
        required this.title,
        required this.video,
        required this.voteAverage,
        required this.voteCount,
    });

    bool adult;
    String? backdropPath;
    List<int> genreIds;
    int id;
    String originalLanguage;
    String originalTitle;
    String overview;
    double popularity;
    String? posterPath;
    String? releaseDate;
    String title;
    bool video;
    double voteAverage;
    int voteCount;

    String? heroId;

    // Obtiene la dirección de las portadas de las peliculas que deben ir en nuestro primer slider:
    get fullPosterImg {

      if( this.posterPath != null )
        return 'https://image.tmdb.org/t/p/w500/${this.posterPath}';
      
      return 'https://i.stack.imgur.com/GNhx0.png';
        
    }

    // Obtiene la imagen de las peliculas populares:
    get popularMovies {

      return 'https://image.tmdb.org/t/p/w500/${this.posterPath}';
      
    }

    // Obtiene la dirección de la imagen que debe ir en los detallees de la pelicula:
    get fullBackdropPath {

      if( this.backdropPath != null )
        return 'https://image.tmdb.org/t/p/w500/${this.backdropPath}';

      return 'https://i.stack.imgur.com/GNhx0.png';

    }

    factory Movie.fromJson(String str) => Movie.fromMap(json.decode(str));

    factory Movie.fromMap(Map<String, dynamic> json) => Movie(
        adult: json["adult"],
        backdropPath: json["backdrop_path"] == null ? null : json["backdrop_path"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        originalLanguage: json["original_language"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        releaseDate: json["release_date"],
        title: json["title"],
        video: json["video"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
    );

}

