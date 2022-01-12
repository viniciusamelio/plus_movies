import 'core_error.dart';

class RepositoryError extends CoreError {
  RepositoryError(message) : super(message: message, code: 400);
}
