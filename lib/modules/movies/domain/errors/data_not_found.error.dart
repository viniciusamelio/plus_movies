import 'package:plus_movies/core/domain/errors/errors.dart';

class MovieDataNotFoundError extends CoreError {
  MovieDataNotFoundError()
      : super(message: "Dados do filme não encontrado", code: 404);
}
