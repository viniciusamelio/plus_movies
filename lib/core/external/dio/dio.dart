import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:plus_movies/core/external/dio/interceptors/interceptors.dart';

class CustomDio extends DioForNative {
  CustomDio(BaseOptions options) : super(options) {
    _setupInterceptors();
  }
  void _setupInterceptors() {
    interceptors.add(movieDBTokenInterceptor);
  }
}
