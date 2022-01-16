import 'package:plus_movies/modules/movies/domain/entities/entities.dart';

class GenreMapper {
  static Genre mapToObject(Map<String, dynamic> map) {
    return Genre(
      id: map["id"],
      name: map["name"],
    );
  }

  static Map objectToMap(Genre genre) {
    return {
      "id": genre.id,
      "name": genre.name,
    };
  }
}
