import 'package:fpdart/fpdart.dart';

import 'package:plus_movies/core/infra/errors/errors.dart';
import 'package:plus_movies/core/infra/services/cache.service.dart';
import 'package:plus_movies/modules/movies/domain/entities/movie.entity.dart';
import 'package:plus_movies/core/domain/errors/core_error.dart';
import 'package:plus_movies/modules/movies/domain/protocols/protocols.dart';
import 'package:plus_movies/modules/movies/infra/mappers/mappers.dart';

class CacheMoviesRepository extends MoviesRepository {
  final CacheService _cacheService;

  CacheMoviesRepository(this._cacheService);

  @override
  Future<Either<CoreError, Movie>> create(Movie entity) async {
    try {
      _cacheService.save(
        entity.id.toString(),
        MovieMapper.objectToMap(
          entity,
        ),
      );
      return Right(entity);
    } catch (e) {
      return Left(CacheSavingError());
    }
  }

  @override
  Future<Either<CoreError, List<Movie>>> createAll(List<Movie> data) async {
    try {
      for (var movie in data) {
        _cacheService.save(
          movie.id.toString(),
          MovieMapper.objectToMap(movie),
        );
      }
      return Right(data);
    } catch (e) {
      return Left(CacheSavingError());
    }
  }

  @override
  Future<Either<CoreError, Movie>> find(String id) async {
    try {
      return Right(
        MovieMapper.mapToObject(
          _cacheService.find(id),
        ),
      );
    } catch (e) {
      return Left(CacheRetrieveError());
    }
  }

  @override
  Future<Either<CoreError, List<Movie>>> findAll() async {
    try {
      final List<Map<String, dynamic>> values = await _cacheService.findAll();
      return Right(
        values
            .map(
              (e) => MovieMapper.mapToObject(e),
            )
            .toList(),
      );
    } catch (e) {
      return Left(CacheRetrieveError());
    }
  }
}
