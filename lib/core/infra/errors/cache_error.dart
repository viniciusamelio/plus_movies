import 'package:plus_movies/core/domain/errors/errors.dart';

class CacheSavingError extends CoreError {
  CacheSavingError()
      : super(
          message: "Não foi possível salvar os dados ao cache",
          code: 400,
        );
}

class CacheRetrieveError extends CoreError {
  CacheRetrieveError()
      : super(
          message: "Não foi possível recuperar os dados do cache",
          code: 400,
        );
}
