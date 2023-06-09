import 'package:realm_roller/assets_handlers/entities_saver/saver_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalStorage {
  static late SharedPreferences localStorage;

  static Future init() async {
    localStorage = await SharedPreferences.getInstance();
  }

  static List getEntities(Type type) {
    if (!entitiesToPaths.containsKey(type)) {
      throw Exception("No entities of type $type");
    }
    final entities = localStorage.getStringList(entitiesToPaths[type]!);

    if (entities == null) {
      return [];
    }
    final saveable = entitiesToSaveables[type]!;
    return entities.map(saveable.fromJson).toList();
  }

  static void saveEntity(dynamic entity) {
    final type = entity.runtimeType;

    final entities = getEntities(type);
    final saveable = entitiesToSaveables[type]!;

    if (!entities.contains(entity)) {
      entities.add(entity);
    }

    localStorage.setStringList(
      entitiesToPaths[type]!,
      entities.map<String>(saveable.toJson).toList(),
    );
  }

  static void deleteEntity(dynamic entity) {
    final type = entity.runtimeType;

    final entities = getEntities(type)..remove(entity);
    final saveable = entitiesToSaveables[type]!;

    localStorage.setStringList(
      entitiesToPaths[type]!,
      entities.map<String>(saveable.toJson).toList(),
    );
  }

  static bool isEntitySaved(dynamic entity) {
    final type = entity.runtimeType;
    final entities = getEntities(type);
    return entities.contains(entity);
  }
}
