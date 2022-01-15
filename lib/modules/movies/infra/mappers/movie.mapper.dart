import 'package:plus_movies/modules/movies/domain/entities/entities.dart';
import 'package:plus_movies/modules/movies/infra/mappers/company.mapper.dart';
import 'package:plus_movies/modules/movies/infra/mappers/genre.mapper.dart';
import 'package:plus_movies/modules/movies/infra/mappers/professional.mapper.dart';

class MovieMapper {
  static Movie mapToObject(Map<String, dynamic> map) {
    final List<Map<String, dynamic>> genres = map["genres"];
    final List<Map<String, dynamic>> companies = map["production_companies"];
    final List<Map<String, dynamic>> cast = map["cast"];
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
        voteAvarage: map["vote_avarage"],
        voteCount: map["vote_count"],
        overview: map["overview"]);
  }
}
