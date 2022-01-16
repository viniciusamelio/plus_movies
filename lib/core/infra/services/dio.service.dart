import 'package:plus_movies/core/external/dio/dio.dart';
import 'package:plus_movies/core/infra/services/http.service.dart';

class DioService implements HttpService {
  final CustomDio _dio;

  DioService(this._dio);

  @override
  Future<dynamic> get(String path, {Map<String, dynamic>? options}) async {
    try {
      final result = await _dio.get(path);
      return result.data;
    } catch (e) {
      rethrow;
    }
  }
}
