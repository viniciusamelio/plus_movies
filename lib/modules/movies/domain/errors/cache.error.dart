import 'package:plus_movies/core/domain/errors/errors.dart';

class MovieCacheError extends CoreError {
  MovieCacheError()
      : super(
            message: "Erro ao recuperar os dados do filme em cache", code: 400);
}
