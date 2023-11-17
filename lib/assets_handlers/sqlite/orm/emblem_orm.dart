import 'package:randpg/entities/emblems.dart';
import 'package:realm_roller/assets_handlers/sqlite/db_manager.dart';
import 'package:realm_roller/assets_handlers/sqlite/orm/saved_entity.dart';

/// ORM of the emblem entity
class EmblemOrm {
  static const _tableName = "emblems";

  /// Inserts an emblem into the db
  static Future<int> insertEmblem(SavedEntity<Emblem> emblem) async {
    return await DBManager.database.insert(_tableName, _getEmblemMap(emblem));
  }

  /// Updates an emblem with [id] to [newEmblem]
  static Future<void> updateEmblem(
    int id,
    SavedEntity<Emblem> newEmblem,
  ) async {
    await DBManager.database.update(
      _tableName,
      _getEmblemMap(newEmblem),
      where: "id = ?",
      whereArgs: [id],
    );
  }

  /// Deletes an emblem with id [id]
  static Future<void> deleteEmblem(int id) async {
    await DBManager.database.delete(
      _tableName,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  /// Gets all emblems where isSaved is true
  static Future<List<SavedEntity<Emblem>>> getSavedEmblems() async {
    final result = await DBManager.database.query(
      _tableName,
      where: "isSaved = ?",
      whereArgs: [1],
    );

    return List.generate(
      result.length,
      (i) => SavedEntity(
        entity: Emblem.fromJson(result[i]["emblemData"] as String),
        isSaved: result[i]["isSaved"] != 0,
        isSavedByParent: result[i]["isSavedByParent"] != 0,
        id: result[i]["id"] as int,
      ),
    );
  }

  static Map<String, dynamic> _getEmblemMap(SavedEntity<Emblem> emblem) => {
        "isSaved": emblem.isSaved ? 1 : 0,
        "isSavedByParent": emblem.isSavedByParent ? 1 : 0,
        "emblemData": emblem.entity.toJson(),
      };
}
