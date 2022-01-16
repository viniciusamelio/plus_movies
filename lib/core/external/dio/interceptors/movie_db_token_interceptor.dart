import 'package:dio/dio.dart';

import 'package:plus_movies/env.dart';

final movieDBTokenInterceptor =
    InterceptorsWrapper(onRequest: (options, handlers) {
  if (options.baseUrl.contains(movieDBBaseUrl)) {
    options.path += "?api_key=$movieDBKey&language=pt-BR";
  }
  return handlers.next(options);
});
