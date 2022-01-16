abstract class CacheService {
  void save(String key, dynamic value);
  void delete(String key);
  find(String key);
  findAll();
}
