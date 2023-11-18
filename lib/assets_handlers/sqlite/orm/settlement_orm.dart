import 'package:randpg/entities/settlements.dart';
import 'package:realm_roller/assets_handlers/sqlite/db_manager.dart';
import 'package:realm_roller/assets_handlers/sqlite/orm/location_orm.dart';
import 'package:realm_roller/assets_handlers/sqlite/orm/npc_orm.dart';
import 'package:realm_roller/assets_handlers/sqlite/orm/saveable_entity.dart';

/// An orm for settlements
class SettlementOrm {
  static const _tableName = "settlements";

  static Future<int> insertSettlement(
    SaveableEntity<Settlement> settlement, {
    int? importantIn,
  }) async {
    final id = await DBManager.database.insert(
      _tableName,
      _getSettlementMap(settlement, importantIn: importantIn),
    );

    for (final location in settlement.entity.locations) {
      await LocationOrm.insertLocation(
        SaveableEntity(
          entity: location,
          isSaved: false,
          isSavedByParent: true,
        ),
        locatedIn: id,
      );
    }

    for (final npc in settlement.entity.importantCharacters) {
      await NpcOrm.insertNpc(
        SaveableEntity(
          entity: npc,
          isSaved: false,
          isSavedByParent: true,
        ),
        importantIn: id,
      );
    }

    return id;
  }

  static Future<void> updateSettlement(
    int id,
    SaveableEntity<Settlement> newSettlement, {
    int? importantIn,
  }) async {
    await DBManager.database.update(
      _tableName,
      _getSettlementMap(newSettlement, importantIn: importantIn),
      where: "id = ?",
      whereArgs: [id],
    );
  }

  static Future<void> deleteSettlement(int id) async {
    await DBManager.database.delete(
      _tableName,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  static Future<List<SaveableEntity<Settlement>>> getSavedSettlements() async {
    return querySettlements("isSaved = ?", whereArgs: [1]);
  }

  static Future<List<SaveableEntity<Settlement>>> querySettlements(String where,
      {List<Object?>? whereArgs}) async {
    final result = await DBManager.database.query(
      _tableName,
      where: where,
      whereArgs: whereArgs,
    );

    final List<SaveableEntity<Settlement>> list = [];
    for (final map in result) {
      list.add(SaveableEntity(
        entity: await _getSettlementEntity(map),
        isSaved: map["isSaved"] != 0,
        isSavedByParent: map["isSavedByParent"] != 0,
        id: map["id"] as int,
      ));
    }

    return list;
  }

  static Future<SaveableEntity<Settlement>> getSettlementById(int id) async {
    final result = (await DBManager.database.query(
      _tableName,
      where: "id = ?",
      whereArgs: [id],
    ))[0];

    return SaveableEntity(
      entity: await _getSettlementEntity(result),
      isSaved: result["isSaved"] != 0,
      isSavedByParent: result["isSavedByParent"] != 0,
      id: result["id"] as int,
    );
  }

  static Map<String, dynamic> _getSettlementMap(
    SaveableEntity<Settlement> settlement, {
    int? importantIn,
  }) {
    final map = settlement.entity.toMap();
    map["isSaved"] = settlement.isSaved ? 1 : 0;
    map["isSavedByParent"] = settlement.isSavedByParent ? 1 : 0;
    map["importantIn"] = importantIn;
    map.remove("locations");
    map.remove("importantCharacters");
    return map;
  }

  static Future<Settlement> _getSettlementEntity(
    Map<String, dynamic> dbMap,
  ) async {
    final map = Map<String, dynamic>.from(dbMap);
    map["locations"] = (await LocationOrm.queryLocations(
      "locatedIn = ?",
      whereArgs: [map["id"]],
    ))
        .map((e) => e.entity.toMap())
        .toList();
    map["importantCharacters"] = (await NpcOrm.queryNpcs(
      "importantIn = ?",
      whereArgs: [map["id"]],
    ))
        .map((e) => e.entity.toMap())
        .toList();
    return Settlement.fromMap(map);
  }
}
