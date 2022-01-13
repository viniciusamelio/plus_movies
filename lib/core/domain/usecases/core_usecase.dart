import 'package:fpdart/fpdart.dart';

import 'package:plus_movies/core/domain/errors/core_error.dart';

abstract class CoreUsecase {
  Future<Either<CoreError, dynamic>> call();
}
