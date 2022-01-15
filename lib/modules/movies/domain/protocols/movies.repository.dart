import 'package:fpdart/fpdart.dart';

import 'package:plus_movies/core/domain/errors/errors.dart';
import 'package:plus_movies/core/domain/protocols/core_repository.dart';
import 'package:plus_movies/modules/movies/domain/entities/movie.entity.dart';

abstract class MoviesRepository extends CoreRepository<Movie> {
  Future<Either<CoreError, List<Movie>>> createAll(List<Movie> data);
}
