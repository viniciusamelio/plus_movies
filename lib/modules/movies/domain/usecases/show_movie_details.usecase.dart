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

class ShowMovieDetails extends ShowMovieDetailsUsecase {
  ShowMovieDetails({
    required MoviesRepository networkMoviesRepository,
    required MoviesRepository cacheMoviesRepository,
  }) : super(
          networkMoviesRepository,
          cacheMoviesRepository,
        );

  @override
  Future<Either<CoreError, Movie>> call(String id) async {
    final cachedMovieDataOrError = await _cacheRepository.find(id);
    return cachedMovieDataOrError.fold((error) async {
      final networkMovieDataOrError = await _networkRepository.find(id);
      return networkMovieDataOrError.fold(
          (error) => Left(error), (data) => Right(data));
    }, (data) {
      return Right(data);
    });
  }
}
