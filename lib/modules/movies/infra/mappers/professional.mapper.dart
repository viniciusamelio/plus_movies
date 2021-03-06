import 'package:plus_movies/modules/movies/domain/entities/entities.dart';

class ProfessionalMapper {
  static Professional mapToObject(Map<String, dynamic> map) {
    return Professional(
      id: map["id"],
      name: map["name"],
      department: map["known_for_department"],
    );
  }

  static Map objectToMap(Professional professional) => {
        "id": professional.id,
        "name": professional.name,
        "known_for_department": professional.department,
      };
}
