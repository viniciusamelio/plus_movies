import 'package:get_storage/get_storage.dart';
import 'package:plus_movies/core/infra/services/cache.service.dart';

class GetStorageService implements CacheService {
  final GetStorage _storage;
  final String prefix = "movie";
  GetStorageService(this._storage);

  static void init() async {
    await GetStorage.init();
  }

  @override
  void delete(String key) {
    _storage.remove("$prefix-$key");
  }

  @override
  find(String key) {
    return _storage.read("$prefix-$key");
  }

  @override
  findAll() {
    return _storage.getValues();
  }

  @override
  void save(String key, value) {
    _storage.write("$prefix-$key", value);
  }
}
