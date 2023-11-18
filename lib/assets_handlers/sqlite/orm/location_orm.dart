import 'dart:convert';

import 'package:randpg/entities/settlements.dart';
import 'package:realm_roller/assets_handlers/sqlite/db_manager.dart';
import 'package:realm_roller/assets_handlers/sqlite/orm/npc_orm.dart';
import 'package:realm_roller/assets_handlers/sqlite/orm/saveable_entity.dart';

/// An orm for locations
class LocationOrm {
  static const _tableName = "locations";

  static Future<int> insertLocation(
    SaveableEntity<Location> location, {
    int? locatedIn,
  }) async {
    return DBManager.database.insert(
      _tableName,
      await _getLocationMap(
        location,
        locatedIn: locatedIn,
      ),
    );
  }

  static Future<void> updateLocation(
    int id,
    SaveableEntity<Location> newLocation, {
    int? locatedIn,
  }) async {
    await DBManager.database.execute(
      "DELETE FROM npcs WHERE id IN (SELECT ownerId FROM location WHERE id = ?)",
      [id],
    );
    await DBManager.database.update(
      _tableName,
      await _getLocationMap(newLocation, locatedIn: locatedIn),
      where: "id = ?",
      whereArgs: [id],
    );
  }

  static Future<void> deleteLocation(int id) async {
    await DBManager.database.execute(
      "DELETE FROM npcs WHERE id IN (SELECT ownerId FROM location WHERE id = ?)",
      [id],
    );
    await DBManager.database.delete(
      _tableName,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  static Future<List<SaveableEntity<Location>>> getSavedLocations() async {
    return queryLocations("isSaved = ?", whereArgs: [1]);
  }

  static Future<List<SaveableEntity<Location>>> queryLocations(
    String where, {
    List<Object?>? whereArgs,
  }) async {
    final result = await DBManager.database.query(
      _tableName,
      where: where,
      whereArgs: whereArgs,
    );

    final List<SaveableEntity<Location>> list = [];
    for (final map in result) {
      list.add(SaveableEntity(
        entity: await _getLocationEntity(map),
        isSaved: map["isSaved"] != 0,
        isSavedByParent: map["isSavedByParent"] != 0,
        id: map["id"] as int,
      ));
    }

    return list;
  }

  static Future<Map<String, dynamic>> _getLocationMap(
    SaveableEntity<Location> location, {
    int? locatedIn,
  }) async {
    final entity = location.entity;
    final ownerId = await NpcOrm.insertNpc(
      SaveableEntity(
        entity: location.entity.owner,
        isSaved: false,
        isSavedByParent: true,
      ),
    );
    return {
      "isSaved": location.isSaved ? 1 : 0,
      "isSavedByParent": location.isSavedByParent ? 1 : 0,
      "locatedIn": locatedIn,
      "goods": jsonEncode(entity.goods),
      'name': entity.name,
      'type': entity.type.getLocationType(),
      'zone': entity.zone,
      'outsideDescription': jsonEncode(entity.outsideDescription),
      'buildingDescription': entity.buildingDescription,
      "ownerId": ownerId,
    };
  }

  static Future<Location> _getLocationEntity(Map<String, dynamic> dbMap) async {
    final map = Map<String, dynamic>.from(dbMap);
    map["owner"] = (await NpcOrm.getNpcById(map["ownerId"])).entity.toMap();
    map["goods"] = jsonDecode(map["goods"])?.map((g) => jsonDecode(g)).toList();
    map["outsideDescription"] = jsonDecode(map["outsideDescription"]);
    return Location.fromMap(map);
  }
}
