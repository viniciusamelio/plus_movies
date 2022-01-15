import 'package:flutter_test/flutter_test.dart';

import 'package:fpdart/src/either.dart';
import 'package:mocktail/mocktail.dart';

import 'package:plus_movies/modules/movies/domain/protocols/protocols.dart';
import 'package:plus_movies/modules/movies/domain/usecases/list_movies.usecase.dart';
import 'package:plus_movies/modules/movies/domain/entities/entities.dart';
import 'package:plus_movies/core/domain/errors/errors.dart';

class FakeNetworkMovieRepository extends Mock implements MoviesRepository {}

class FakeCacheMovieRepository extends Mock implements MoviesRepository {}

class FakeMovie extends Mock implements Movie {}

class ListMovies extends ListMoviesUsecase {
  ListMovies({
    required MoviesRepository networkMoviesRepository,
    required MoviesRepository cacheMoviesRepository,
  }) : super(
          networkRepository: networkMoviesRepository,
          cacheRepository: cacheMoviesRepository,
        );

  @override
  Future<Either<CoreError, List<Movie>>> call() async {
    final cachedDataOrError = await cacheRepository.findAll();
    if (cachedDataOrError.isLeft()) {
      final networkDataOrError = await networkRepository.findAll();
      return networkDataOrError.fold(
        (error) => Left(error),
        (data) {
          cacheRepository.createAll(data);
          return Right(data);
        },
      );
    }
    return cachedDataOrError.fold(
      (error) => left(error),
      (data) => right(data),
    );
  }
}

void main() {
  group("List Movies Usecase", () {
    late final ListMoviesUsecase sut;
    late final MoviesRepository networkMoviesRepo;
    late final MoviesRepository cacheMoviesRepo;

    setUp(() {
      networkMoviesRepo = FakeNetworkMovieRepository();
      cacheMoviesRepo = FakeCacheMovieRepository();
      sut = ListMovies(
        networkMoviesRepository: networkMoviesRepo,
        cacheMoviesRepository: cacheMoviesRepo,
      );
    });

    setUpAll(() {
      registerFallbackValue(FakeMovie());
    });
    test('Should retrieve movies data from network when there is no cache',
        () async {
      when(
        () => cacheMoviesRepo.findAll(),
      ).thenAnswer(
        (_) async => Left(
          RepositoryError(
            "Dados dos filmes não encontrados",
            code: 404,
          ),
        ),
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
    });
  });
}
