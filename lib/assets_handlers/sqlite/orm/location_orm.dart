import 'dart:convert';

import 'package:randpg/entities/settlements.dart';
import 'package:realm_roller/assets_handlers/sqlite/db_manager.dart';
import 'package:realm_roller/assets_handlers/sqlite/orm/npc_orm.dart';
import 'package:realm_roller/assets_handlers/sqlite/orm/saved_entity.dart';

/// An orm for locations
class LocationOrm {
  static const _tableName = "locations";

  static Future<int> insertLocation(
    SavedEntity<Location> location, {
    int? locatedIn,
  }) async {
    return await DBManager.database.insert(
      _tableName,
      await _getLocationMap(
        location,
        locatedIn: locatedIn,
      ),
    );
  }

  static Future<void> updateLocation(
    int id,
    SavedEntity<Location> newLocation, {
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
    await DBManager.database.delete(
      _tableName,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  static Future<List<SavedEntity<Location>>> getSavedLocations() async {
    final result = await DBManager.database.query(
      _tableName,
      where: "isSaved = ?",
      whereArgs: [1],
    );

    final List<SavedEntity<Location>> list = [];
    for (final map in result) {
      list.add(SavedEntity(
        entity: await _getLocationEntity(map),
        isSaved: map["isSaved"] != 0,
        isSavedByParent: map["isSavedByParent"] != 0,
        id: map["id"] as int,
      ));
    }

    return list;
  }

  static Future<Map<String, dynamic>> _getLocationMap(
    SavedEntity<Location> location, {
    int? locatedIn,
  }) async {
    final map = location.entity.toMap();
    map["isSaved"] = location.isSaved ? 1 : 0;
    map["isSavedByParent"] = location.isSavedByParent ? 1 : 0;
    map["locatedIn"] = locatedIn;
    map["goods"] = jsonEncode(location.entity.goods);
    map["outsideDescription"] = jsonEncode(location.entity.outsideDescription);
    map["ownerId"] = await NpcOrm.insertNpc(
      SavedEntity(
        entity: location.entity.owner,
        isSaved: false,
        isSavedByParent: true,
      ),
    );
    map.remove("owner");

    return map;
  }

  static Future<Location> _getLocationEntity(Map<String, dynamic> dbMap) async {
    final map = Map<String, dynamic>.from(dbMap);
    map["owner"] = (await NpcOrm.getNpcById(map["ownerId"])).entity.toMap();
    map["goods"] = jsonDecode(map["goods"]).map((g) => jsonDecode(g)).toList();
    map["outsideDescription"] = jsonDecode(map["outsideDescription"]);
    return Location.fromMap(map);
  }
}
