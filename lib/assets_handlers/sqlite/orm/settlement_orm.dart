import 'package:randpg/entities/settlements.dart';
import 'package:realm_roller/assets_handlers/sqlite/db_manager.dart';
import 'package:realm_roller/assets_handlers/sqlite/orm/location_orm.dart';
import 'package:realm_roller/assets_handlers/sqlite/orm/npc_orm.dart';
import 'package:realm_roller/assets_handlers/sqlite/orm/saved_entity.dart';

/// An orm for settlements
class SettlementOrm {
  static const _tableName = "settlements";

  static Future<int> insertSettlement(
    SavedEntity<Settlement> settlement, {
    int? importantIn,
  }) async {
    final id = await DBManager.database.insert(
      _tableName,
      _getSettlementMap(settlement, importantIn: importantIn),
    );

    for (final location in settlement.entity.locations) {
      await LocationOrm.insertLocation(
        SavedEntity(
          entity: location,
          isSaved: false,
          isSavedByParent: true,
        ),
        locatedIn: id,
      );
    }

    for (final npc in settlement.entity.importantCharacters) {
      await NpcOrm.insertNpc(
        SavedEntity(
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
    SavedEntity<Settlement> newSettlement, {
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

  static Future<List<SavedEntity<Settlement>>> getSavedSettlements() async {
    final result = await DBManager.database.query(
      _tableName,
      where: "isSaved = ?",
      whereArgs: [1],
    );

    final List<SavedEntity<Settlement>> list = [];
    for (final map in result) {
      list.add(SavedEntity(
        entity: await _getSettlementEntity(map),
        isSaved: map["isSaved"] != 0,
        isSavedByParent: map["isSavedByParent"] != 0,
        id: map["id"] as int,
      ));
    }

    return list;
  }

  static Map<String, dynamic> _getSettlementMap(
    SavedEntity<Settlement> settlement, {
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
