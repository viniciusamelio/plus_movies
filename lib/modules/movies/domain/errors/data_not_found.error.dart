import 'package:plus_movies/core/domain/errors/errors.dart';

class MovieDataNotFound extends CoreError {
  MovieDataNotFound()
      : super(message: "Dados do filme não encontrado", code: 404);
}
