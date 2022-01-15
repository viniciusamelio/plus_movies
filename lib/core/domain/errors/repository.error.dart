import 'core_error.dart';

class RepositoryError extends CoreError {
  RepositoryError(String message, {int code = 400})
      : super(message: message, code: code);
}
