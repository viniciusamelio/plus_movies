import 'package:fpdart/fpdart.dart';

import 'package:plus_movies/core/domain/errors/errors.dart';
import 'package:plus_movies/modules/movies/domain/entities/entities.dart';
import 'package:plus_movies/modules/movies/domain/protocols/movies.repository.dart';

abstract class ShowMovieDetailsUsecase {
  final MoviesRepository _networkRepository;
  final MoviesRepository _cacheRepository;

  ShowMovieDetailsUsecase(this._networkRepository, this._cacheRepository);

  Future<Either<CoreError, Movie>> call(String id);
}
