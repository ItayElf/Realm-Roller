import 'package:realm_roller/assets_handlers/entities_saver/saver_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalStorage {
  static late SharedPreferences localStorage;

  static Future init() async {
    localStorage = await SharedPreferences.getInstance();
  }

  static List<T> getEntities<T>() {
    if (!entitiesToPaths.containsKey(T)) {
      throw Exception("No entities of type $T");
    }
    final entities = localStorage.getStringList(entitiesToPaths[T]!);
    if (entities == null) {
      return [];
    }
    final saveable = entitiesToSaveables[T]!;
    return entities.map(saveable.fromJson).toList() as List<T>;
  }

  static void saveEntity(dynamic entity) {
    final type = entity.runtimeType;
    if (!entitiesToPaths.containsKey(type)) {
      throw Exception("No entities of type $type");
    }

    final entities = getEntities()..add(entity);
    final saveable = entitiesToSaveables[type]!;

    localStorage.setStringList(
      entitiesToPaths[type]!,
      entities.map<String>(saveable.toJson).toList(),
    );
  }

  static void deleteEntity(dynamic entity) {
    final type = entity.runtimeType;
    if (!entitiesToPaths.containsKey(type)) {
      throw Exception("No entities of type $type");
    }

    final entities = getEntities()..remove(entity);
    final saveable = entitiesToSaveables[type]!;

    localStorage.setStringList(
      entitiesToPaths[type]!,
      entities.map<String>(saveable.toJson).toList(),
    );
  }
}
