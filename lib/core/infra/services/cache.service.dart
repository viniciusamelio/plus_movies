abstract class CacheService {
  void save(String key, dynamic value);
  void delete(String key);
  void find(String key, dynamic value);
  void findAll(String key, dynamic value);
}
