import 'package:plus_movies/modules/movies/domain/entities/entities.dart';

class Movie {
  final int id;
  final int budget;
  final String title;
  final String originalTitle;
  final String posterPath;
  final String backdropPath;
  final DateTime releaseDate;
  final int ravenue;
  final List<Genre> genres;
  final List<Company> productionCompanies;
  final List<Professional> cast;
  final int? runtime;
  final double voteAvarage;
  final int voteCount;
  final String overview;

  Movie({
    required this.id,
    required this.budget,
    required this.title,
    required this.originalTitle,
    required this.posterPath,
    required this.backdropPath,
    required this.releaseDate,
    required this.ravenue,
    required this.genres,
    required this.productionCompanies,
    required this.cast,
    this.runtime,
    required this.voteAvarage,
    required this.voteCount,
    required this.overview,
  });
}
