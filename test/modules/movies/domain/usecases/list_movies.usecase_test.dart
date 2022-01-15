import 'package:flutter_test/flutter_test.dart';

import 'package:fpdart/src/either.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plus_movies/modules/movies/domain/errors/data_not_found.error.dart';

import 'package:plus_movies/modules/movies/domain/protocols/protocols.dart';
import 'package:plus_movies/modules/movies/domain/usecases/list_movies.usecase.dart';
import 'package:plus_movies/modules/movies/domain/entities/entities.dart';
import 'package:plus_movies/core/domain/errors/errors.dart';

class FakeNetworkMovieRepository extends Mock implements MoviesRepository {}

class FakeCacheMovieRepository extends Mock implements MoviesRepository {}

class FakeMovie extends Mock implements Movie {}

void main() {
  group("List Movies Usecase", () {
    late final ListMoviesUsecase sut;
    late final MoviesRepository networkMoviesRepo;
    late final MoviesRepository cacheMoviesRepo;

    setUpAll(() {
      networkMoviesRepo = FakeNetworkMovieRepository();
      cacheMoviesRepo = FakeCacheMovieRepository();
      sut = ListMovies(
        networkMoviesRepository: networkMoviesRepo,
        cacheMoviesRepository: cacheMoviesRepo,
      );
      registerFallbackValue(FakeMovie());
    });
    test('Should retrieve movies data from network when there is no cache',
        () async {
      when(
        () => cacheMoviesRepo.findAll(),
      ).thenAnswer(
        (_) async => Left(MovieDataNotFoundError()),
      );
      when(
        () => networkMoviesRepo.findAll(),
      ).thenAnswer(
        (_) async => Right([
          FakeMovie(),
        ]),
      );
      when(
        () => cacheMoviesRepo.createAll(any()),
      ).thenAnswer(
        (_) async => Right([
          FakeMovie(),
        ]),
      );

      final result = await sut.call();

      expect(result.isRight(), equals(true));
      verify(() => cacheMoviesRepo.createAll(any())).called(1);
      verify(() => cacheMoviesRepo.findAll()).called(1);
      verify(() => networkMoviesRepo.findAll()).called(1);
    });
    test('Should retrieve cached movies data when it is storaged', () async {
      when(
        () => cacheMoviesRepo.findAll(),
      ).thenAnswer(
        (_) async => Right([FakeMovie(), FakeMovie(), FakeMovie()]),
      );

      final result = await sut.call();

      expect(result.isRight(), equals(true));
      verify(() => cacheMoviesRepo.findAll()).called(1);
      result.fold((l) => null, (data) {
        expect(data, isList);
        expect(data[0], isInstanceOf<Movie>());
      });
    });
    test(
        'Should return a left when network repository fails and there is no cache available',
        () async {
      when(
        () => cacheMoviesRepo.findAll(),
      ).thenAnswer(
        (_) async => Left(MovieDataNotFoundError()),
      );
      when(
        () => networkMoviesRepo.findAll(),
      ).thenAnswer(
        (_) async => Left(MovieDataNotFoundError()),
      );

      final result = await sut.call();

      expect(result.isLeft(), equals(true));
      verify(() => cacheMoviesRepo.findAll()).called(1);
      verify(() => networkMoviesRepo.findAll()).called(1);
      result.fold(
          (error) => expect(error, isInstanceOf<MovieDataNotFoundError>()),
          (r) => null);
    });
  });
}
