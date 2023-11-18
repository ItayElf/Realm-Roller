import 'dart:convert';

import 'package:randpg/entities/deities.dart';
import 'package:realm_roller/assets_handlers/sqlite/db_manager.dart';
import 'package:realm_roller/assets_handlers/sqlite/orm/saveable_entity.dart';

/// An orm for deities
class DeityOrm {
  static const _tableName = "deities";

  static Future<int> insertDeity(
    SaveableEntity<Deity> deity, {
    int? deityIn,
    int? lesserDeityIn,
    int? higherDeityIn,
  }) async {
    return DBManager.database.insert(
      _tableName,
      _getDeityMap(
        deity,
        deityIn: deityIn,
        lesserDeityIn: lesserDeityIn,
        higherDeityIn: higherDeityIn,
      ),
    );
  }

  static Future<void> updateDeity(
    int id,
    SaveableEntity<Deity> newDeity, {
    int? deityIn,
    int? lesserDeityIn,
    int? higherDeityIn,
  }) async {
    await DBManager.database.update(
      _tableName,
      _getDeityMap(
        newDeity,
        deityIn: deityIn,
        lesserDeityIn: lesserDeityIn,
        higherDeityIn: higherDeityIn,
      ),
      where: "id = ?",
      whereArgs: [id],
    );
  }

  static Future<void> deleteDeity(int id) async {
    await DBManager.database.delete(
      _tableName,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  static Future<List<SaveableEntity<Deity>>> getSavedDeities() async {
    return queryDeities("isSaved = ?", whereArgs: [1]);
  }

  static Future<List<SaveableEntity<Deity>>> queryDeities(
    String where, {
    List<Object?>? whereArgs,
  }) async {
    final result = await DBManager.database.query(
      _tableName,
      where: where,
      whereArgs: whereArgs,
    );

    return List.generate(
      result.length,
      (i) {
        final map = result[i];

        return SaveableEntity(
          entity: _getDeityEntity(map),
          isSaved: map["isSaved"] != 0,
          isSavedByParent: map["isSavedByParent"] != 0,
          id: map["id"] as int,
        );
      },
    );
  }

  static Map<String, dynamic> _getDeityMap(
    SaveableEntity<Deity> deity, {
    int? deityIn,
    int? lesserDeityIn,
    int? higherDeityIn,
  }) {
    final map = deity.entity.toMap();
    map["isSaved"] = deity.isSaved ? 1 : 0;
    map["isSavedByParent"] = deity.isSavedByParent ? 1 : 0;
    map["deityIn"] = deityIn;
    map["lesserDeityIn"] = lesserDeityIn;
    map["higherDeityIn"] = higherDeityIn;
    map["alignmentEthical"] = map["ethical"];
    map["alignmentMoral"] = map["moral"];
    map["domains"] = jsonEncode(map["domains"]);
    map.remove("alignment");
    return map;
  }

  static Deity _getDeityEntity(Map<String, dynamic> dbMap) {
    final map = Map<String, dynamic>.from(dbMap);
    map["domains"] = jsonDecode(map["domains"]);
    map["ethical"] = map["alignmentEthical"];
    map["moral"] = map["alignmentMoral"];
    return Deity.fromMap(map);
  }
}
