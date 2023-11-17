import 'dart:convert';

import 'package:randpg/entities/landscapes.dart';
import 'package:realm_roller/assets_handlers/sqlite/db_manager.dart';
import 'package:realm_roller/assets_handlers/sqlite/orm/saved_entity.dart';

/// Orm for landscapes
class LandscapeOrm {
  static const _tableName = "landscapes";

  static Future<int> insertLandscape(
    SavedEntity<Landscape> landscape, {
    int? locatedIn,
  }) async {
    return await DBManager.database.insert(
      _tableName,
      _getLandscapeMap(landscape, locatedIn: locatedIn),
    );
  }

  static Future<void> updateLandscape(
    int id,
    SavedEntity<Landscape> newLandscape, {
    int? locatedIn,
  }) async {
    await DBManager.database.update(
      _tableName,
      _getLandscapeMap(newLandscape, locatedIn: locatedIn),
      where: "id = ?",
      whereArgs: [id],
    );
  }

  static Future<void> deleteLandscape(int id) async {
    await DBManager.database.delete(
      _tableName,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  static Future<List<SavedEntity<Landscape>>> getSavedLandscapes() async {
    final result = await DBManager.database.query(
      _tableName,
      where: "isSaved = ?",
      whereArgs: [1],
    );

    return List.generate(
      result.length,
      (i) {
        final map = result[i];

        return SavedEntity(
          entity: _getLandscapeEntity(map),
          isSaved: map["isSaved"] != 0,
          isSavedByParent: map["isSavedByParent"] != 0,
          id: map["id"] as int,
        );
      },
    );
  }

  static Map<String, dynamic> _getLandscapeMap(SavedEntity<Landscape> landscape,
      {int? locatedIn}) {
    final map = landscape.entity.toMap();
    map["isSaved"] = landscape.isSaved ? 1 : 0;
    map["isSavedByParent"] = landscape.isSavedByParent ? 1 : 0;
    map["locatedIn"] = locatedIn;
    map["features"] = jsonEncode(map["features"]);
    map["resources"] = jsonEncode(map["resources"]);
    map["encounters"] = jsonEncode(map["encounters"]);
    return map;
  }

  static Landscape _getLandscapeEntity(Map<String, dynamic> dbMap) {
    final map = Map<String, dynamic>.from(dbMap);
    map["features"] = jsonDecode(map["features"]);
    map["resources"] = jsonDecode(map["resources"]);
    map["encounters"] = jsonDecode(map["encounters"]);
    return Landscape.fromMap(map);
  }
}
