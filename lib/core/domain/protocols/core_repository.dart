import 'package:fpdart/fpdart.dart';
import 'package:plus_movies/core/domain/errors/core_error.dart';

abstract class CoreRepository<T> {
  Future<Either<CoreError, T>> create(T entity);
  Future<Either<CoreError, T>> update(T entity);
  Future<Either<CoreError, String>> delete(T entity);
  Future<Either<CoreError, T>> find(String id);
  Future<Either<CoreError, List<T>>> findAll();
}
