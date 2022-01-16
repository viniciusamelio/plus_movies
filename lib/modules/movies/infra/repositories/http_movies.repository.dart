import 'dart:async';
import 'dart:io';

import 'package:fpdart/fpdart.dart';

import 'package:plus_movies/core/domain/errors/errors.dart';
import 'package:plus_movies/core/infra/errors/errors.dart';
import 'package:plus_movies/core/infra/services/http.service.dart';
import 'package:plus_movies/modules/movies/domain/entities/movie.entity.dart';
import 'package:plus_movies/modules/movies/domain/protocols/movies.repository.dart';
import 'package:plus_movies/modules/movies/infra/mappers/movie.mapper.dart';

class HttpMoviesRepository extends MoviesRepository {
  final HttpService _dioService;

  HttpMoviesRepository(this._dioService);
  @override
  Future<Either<CoreError, Movie>> create(Movie entity) async {
    throw UnimplementedError();
  }

  @override
  Future<Either<CoreError, List<Movie>>> createAll(List<Movie> data) {
    throw UnimplementedError();
  }

  @override
  Future<Either<CoreError, Movie>> find(String id) async {
    dynamic result;
    try {
      final movieData = await _dioService.get("/movie/$id");
      result = Right(
        MovieMapper.mapToObject(
          (movieData),
        ),
      );
    } on TimeoutException catch (_) {
      result = Left(
        RequestTimeoutError(),
      );
    } on SocketException catch (_) {
      result = Left(NetworkConnectionError());
    } catch (_) {
      result = Right(
          RepositoryError("Houve um erro ao recuperar os dados do filme"));
    }
    return result;
  }

  @override
  Future<Either<CoreError, List<Movie>>> findAll() async {
    dynamic result;
    try {
      final data = await _dioService.get("/movie/now-playing");
      final List<Map<String, dynamic>> movies = data["results"];
      result = Right(
        movies
            .map(
              (data) => MovieMapper.mapToObject(data),
            )
            .toList(),
      );
    } on TimeoutException catch (_) {
      result = Left(
        RequestTimeoutError(),
      );
    } on SocketException catch (_) {
      result = Left(
        NetworkConnectionError(),
      );
    } catch (_) {
      result = Right(
          RepositoryError("Houve um erro ao recuperar os dados do filme"));
    }
    return result;
  }
}
