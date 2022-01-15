import 'package:fpdart/fpdart.dart';

import 'package:plus_movies/core/domain/errors/errors.dart';
import 'package:plus_movies/modules/movies/domain/entities/entities.dart';
import 'package:plus_movies/modules/movies/domain/protocols/movies.repository.dart';

abstract class ShowMovieDetailsUsecase {
  final MoviesRepository networkRepository;
  final MoviesRepository cacheRepository;

  ShowMovieDetailsUsecase({
    required this.networkRepository,
    required this.cacheRepository,
  });

  Future<Either<CoreError, Movie>> call();
}
