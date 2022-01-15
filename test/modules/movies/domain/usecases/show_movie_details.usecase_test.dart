import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/src/either.dart';

import 'package:mocktail/mocktail.dart';
import 'package:plus_movies/core/domain/errors/core_error.dart';

import 'package:plus_movies/modules/movies/domain/entities/entities.dart';
import 'package:plus_movies/modules/movies/domain/protocols/movies.repository.dart';
import 'package:plus_movies/modules/movies/domain/usecases/show_movie_details.usecase.dart';

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
  });
}
