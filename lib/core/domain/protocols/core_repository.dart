import 'package:fpdart/fpdart.dart';
import 'package:plus_movies/core/domain/errors/core_error.dart';

abstract class CoreRepository<T> {
  Either<CoreError, T> create(T entity);
  Either<CoreError, T> update(T entity);
  Either<CoreError, String> delete(T entity);
  Either<CoreError, T> find(T entity);
  Either<CoreError, List<T>> findAll();
}
