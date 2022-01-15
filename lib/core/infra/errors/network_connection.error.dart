import 'package:plus_movies/core/domain/errors/errors.dart';

class NetworkConnectionError extends CoreError {
  NetworkConnectionError()
      : super(
          message:
              "Não foi possível conectar a internet, verifique sua conexão e tente novamente",
          code: 400,
        );
}
