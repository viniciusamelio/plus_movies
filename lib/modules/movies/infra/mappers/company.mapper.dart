import 'package:plus_movies/modules/movies/domain/entities/entities.dart';

class CompanyMapper {
  static Company mapToObject(Map<String, dynamic> map) {
    return Company(
      id: map["id"],
      name: map["name"],
    );
  }
}
