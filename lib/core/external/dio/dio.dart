import 'package:dio/native_imp.dart';
import 'package:plus_movies/core/external/dio/interceptors/interceptors.dart';

class CustomDio extends DioForNative {
  CustomDio() {
    _setupOptions();
    _setupInterceptors();
  }

  void _setupOptions() {
    options.contentType = "application/json";
  }

  void _setupInterceptors() {
    interceptors.add(movieDBTokenInterceptor);
  }
}
