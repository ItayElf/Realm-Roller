import 'package:flutter/material.dart';
import 'package:randpg/general.dart';
import 'package:realm_roller/assets_handlers/local_storage/saver_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalStorage {
  static late SharedPreferences localStorage;

  static const _favoriteGeneratorsKey = "favoriteGenerators";
  static const _defaultFavoriteGenerators = [
    "Names",
    "Npcs",
    "Locations",
  ];

  static Future init() async {
    localStorage = await SharedPreferences.getInstance();

    _setupTypes();
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

    final saveable = entitiesToSaveables[type]!;
    final entities = getEntities(type).map(saveable.toJson).toList();

    if (!entities.contains(entity.toJson())) {
      entities.add(entity.toJson());
    }

    localStorage.setStringList(
      entitiesToPaths[type]!,
      entities,
    );
  }

  static void deleteEntity(dynamic entity) {
    final type = entity.runtimeType;

    final saveable = entitiesToSaveables[type]!;
    final entities = getEntities(type).map(saveable.toJson).toList()
      ..remove(entity.toJson());

    localStorage.setStringList(
      entitiesToPaths[type]!,
      entities,
    );
  }

  static bool isEntitySaved(dynamic entity) {
    final type = entity.runtimeType;
    final entities = getEntities(type);
    final result = entities.map((e) => e.toJson()).contains(entity.toJson());
    debugPrint(result.toString());
    return result;
  }

  static List<T> getAvailableTypes<T>(Manager<T> manager) {
    if (!managersToPaths.containsKey(manager)) {
      throw Exception("No path to manager ${manager.runtimeType}");
    }
    final key = managersToPaths[manager]!;
    final available = localStorage.getStringList(key);

    if (available == null) {
      final list = manager.allTypes.map(getTypeKey).toList();
      localStorage.setStringList(key, list);
      return manager.allTypes;
    }

    return available.map(manager.getType).toList();
  }

  static void registerType(dynamic type) {
    final manager = getManager(type);
    final key = managersToPaths[manager]!;
    final types = getAvailableTypes(manager);

    manager.registerType(type);
    types.add(type);

    localStorage.setStringList(key, types.map(getTypeKey).toList());
  }

  static bool unregisterType(dynamic type) {
    final manager = getManager(type);
    final key = managersToPaths[manager]!;
    final types = getAvailableTypes(manager);

    if (types.length <= 1) {
      return false;
    }
    manager.unregisterType(type);
    types.remove(type);

    localStorage.setStringList(key, types.map(getTypeKey).toList());
    return true;
  }

  static bool isRegistered(dynamic type) =>
      getManager(type).activeTypes.contains(type);

  static void _setupTypes() {
    for (final manager in managersToPaths.keys) {
      final availableTypes = getAvailableTypes(manager);

      manager.activeTypes.forEach(manager.unregisterType);

      availableTypes.forEach(manager.registerType);
    }
  }

  static List<String> getFavoriteGenerators() {
    final favorites = localStorage.getStringList(_favoriteGeneratorsKey);

    if (favorites == null) {
      localStorage.setStringList(
        _favoriteGeneratorsKey,
        _defaultFavoriteGenerators,
      );
      return List.from(_defaultFavoriteGenerators);
    }

    return favorites;
  }

  static addFavoriteGenerator(String generatorName) {
    final favorites = getFavoriteGenerators();
    favorites.add(generatorName);
    localStorage.setStringList(_favoriteGeneratorsKey, favorites);
  }

  static removeFavoriteGenerators(String generatorName) {
    final favorites = getFavoriteGenerators();
    favorites.remove(generatorName);
    localStorage.setStringList(_favoriteGeneratorsKey, favorites);
  }
}
