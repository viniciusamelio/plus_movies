import 'package:plus_movies/core/domain/errors/core_error.dart';

class RequestTimeoutError extends CoreError {
  RequestTimeoutError()
      : super(
          message: "O tempo de sua requisição expirou...",
          code: 400,
        );
}
