import 'package:fpdart/fpdart.dart';

import 'package:plus_movies/core/domain/errors/errors.dart';
import 'package:plus_movies/modules/movies/domain/entities/movie.entity.dart';
import 'package:plus_movies/modules/movies/domain/protocols/protocols.dart';

abstract class ListMoviesUsecase {
  final MoviesRepository _networkRepository;
  final MoviesRepository _cacheRepository;

  ListMoviesUsecase(this._networkRepository, this._cacheRepository);

  Future<Either<CoreError, List<Movie>>> call({useCache = true});
}

class ListMovies extends ListMoviesUsecase {
  ListMovies({
    required MoviesRepository networkMoviesRepository,
    required MoviesRepository cacheMoviesRepository,
  }) : super(
          networkMoviesRepository,
          cacheMoviesRepository,
        );

  @override
  Future<Either<CoreError, List<Movie>>> call({useCache = true}) async {
    final cachedDataOrError = await _cacheRepository.findAll();
    if (!useCache || cachedDataOrError.isLeft()) {
      final networkDataOrError = await _networkRepository.findAll();
      return networkDataOrError.fold(
        (error) => Left(error),
        (data) {
          _cacheRepository.createAll(data);
          return Right(data);
        },
      );
    }
    return cachedDataOrError.fold(
      (error) => Left(error),
      (data) => Right(data),
    );
  }
}
