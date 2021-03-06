import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/src/either.dart';

import 'package:mocktail/mocktail.dart';

import 'package:plus_movies/modules/movies/domain/entities/entities.dart';
import 'package:plus_movies/modules/movies/domain/errors/errors.dart';
import 'package:plus_movies/modules/movies/domain/protocols/movies.repository.dart';
import 'package:plus_movies/modules/movies/domain/usecases/show_movie_details.usecase.dart';
import 'package:plus_movies/core/domain/errors/core_error.dart';

class FakeNetworkMovieRepository extends Mock implements MoviesRepository {}

class FakeCacheMovieRepository extends Mock implements MoviesRepository {}

class FakeMovie extends Mock implements Movie {}

void main() {
  group("Show Movie Details Usecase", () {
    late final ShowMovieDetailsUsecase sut;
    late final MoviesRepository networkRepo;
    late final MoviesRepository cacheRepo;

    setUpAll(() {
      networkRepo = FakeNetworkMovieRepository();
      cacheRepo = FakeCacheMovieRepository();
      sut = ShowMovieDetails(
          networkMoviesRepository: networkRepo,
          cacheMoviesRepository: cacheRepo);
      registerFallbackValue(FakeMovie());
    });

    test("Should return movie when it is cached", () async {
      when(
        () => cacheRepo.find(any()),
      ).thenAnswer(
        (_) async => Right(FakeMovie()),
      );
      const String param = "123";

      final result = await sut.call(param);
      final dataOrError = result.getOrElse((l) => throw l);

      expect(result.isRight(), true);
      expect(dataOrError, isInstanceOf<Movie>());
      verify(() => cacheRepo.find(param)).called(1);
    });
    test("Should return movie from network when it is not cached", () async {
      when(
        () => cacheRepo.find(any()),
      ).thenAnswer(
        (_) async => Left(MovieCacheError()),
      );

      when(
        () => networkRepo.find(any()),
      ).thenAnswer(
        (_) async => Right(FakeMovie()),
      );
      const String param = "123";

      final result = await sut.call(param);
      final dataOrError = result.getOrElse((l) => throw l);

      expect(result.isRight(), true);
      expect(dataOrError, isInstanceOf<Movie>());
      verify(() => cacheRepo.find(param)).called(1);
      verify(() => networkRepo.find(param)).called(1);
    });
    test("Should return left when both network and cache calls fails",
        () async {
      when(
        () => cacheRepo.find(any()),
      ).thenAnswer(
        (_) async => Left(MovieCacheError()),
      );

      when(
        () => networkRepo.find(any()),
      ).thenAnswer(
        (_) async => Left(MovieDataNotFoundError()),
      );
      const String param = "123";

      final result = await sut.call(param);

      expect(result.isLeft(), true);
      result.match(
        (error) => expect(error, isInstanceOf<CoreError>()),
        (r) => null,
      );
      verify(() => cacheRepo.find(param)).called(1);
      verify(() => networkRepo.find(param)).called(1);
    });
  });
}
