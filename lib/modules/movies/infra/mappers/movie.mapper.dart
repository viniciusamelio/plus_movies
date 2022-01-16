import 'package:plus_movies/modules/movies/domain/entities/entities.dart';
import 'package:plus_movies/modules/movies/infra/mappers/company.mapper.dart';
import 'package:plus_movies/modules/movies/infra/mappers/genre.mapper.dart';
import 'package:plus_movies/modules/movies/infra/mappers/professional.mapper.dart';

class MovieMapper {
  static Movie mapToObject(Map<String, dynamic> map) {
    final List<dynamic> genres = map["genres"];
    final List<dynamic> companies = map["production_companies"];
    final List<dynamic> cast = map["cast"];
    return Movie(
        id: map["id"],
        budget: map["budget"],
        title: map["title"],
        originalTitle: map["original_title"],
        posterPath: map["poster_path"],
        backdropPath: map["backdrop_path"],
        releaseDate: map["release_date"],
        revenue: map["revenue"],
        genres: genres.map((e) => GenreMapper.mapToObject(e)).toList(),
        productionCompanies:
            companies.map((e) => CompanyMapper.mapToObject(e)).toList(),
        cast: cast.map((e) => ProfessionalMapper.mapToObject(e)).toList(),
        voteAverage: map["vote_average"],
        voteCount: map["vote_count"],
        overview: map["overview"]);
  }

  static Map objectToMap(Movie movie) => {
        "id": movie.id,
        "budget": movie.budget,
        "title": movie.title,
        "original_title": movie.originalTitle,
        "poster_path": movie.posterPath,
        "backdrop_path": movie.backdropPath,
        "release_date": movie.releaseDate,
        "revenue": movie.revenue,
        "genres": movie.genres
            .map(
              (e) => GenreMapper.objectToMap(e),
            )
            .toList(),
        "production_companies": movie.productionCompanies
            .map(
              (e) => CompanyMapper.objectToMap(e),
            )
            .toList(),
        "cast": movie.cast
            .map(
              (e) => ProfessionalMapper.objectToMap(e),
            )
            .toList(),
        "vote_average": movie.voteAverage,
        "vote_count": movie.voteCount,
        "overview": movie.overview,
      };
}
