import 'dart:convert';

import 'package:randpg/entities/npcs.dart';
import 'package:realm_roller/assets_handlers/sqlite/db_manager.dart';
import 'package:realm_roller/assets_handlers/sqlite/orm/saved_entity.dart';

/// Orm for npcs
class NpcOrm {
  static const _tableName = "npcs";

  static Future<int> insertNpc(
    SavedEntity<Npc> npc, {
    int? importantIn,
    int? notableMemberOf,
    int? rulerOf,
    int? importantInWorld,
  }) async {
    return await DBManager.database.insert(
      _tableName,
      _getNpcMap(
        npc,
        importantIn: importantIn,
        notableMemberOf: notableMemberOf,
        rulerOf: rulerOf,
        importantInWorld: importantInWorld,
      ),
    );
  }

  static Future<void> updateNpc(
    int id,
    SavedEntity<Npc> newNpc, {
    int? importantIn,
    int? notableMemberOf,
    int? rulerOf,
    int? importantInWorld,
  }) async {
    await DBManager.database.update(
      _tableName,
      _getNpcMap(
        newNpc,
        importantIn: importantIn,
        notableMemberOf: notableMemberOf,
        rulerOf: rulerOf,
        importantInWorld: importantInWorld,
      ),
      where: "id = ?",
      whereArgs: [id],
    );
  }

  static Future<void> deleteNpc(int id) async {
    await DBManager.database.delete(
      _tableName,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  static Future<List<SavedEntity<Npc>>> getSavedNpcs() async {
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
          entity: _getNpcEntity(map),
          isSaved: map["isSaved"] != 0,
          isSavedByParent: map["isSavedByParent"] != 0,
          id: map["id"] as int,
        );
      },
    );
  }

  static Future<SavedEntity<Npc>> getNpcById(int id) async {
    final result = (await DBManager.database.query(
      _tableName,
      where: "id = ?",
      whereArgs: [id],
    ))[0];

    return SavedEntity(
      entity: _getNpcEntity(result),
      isSaved: result["isSaved"] != 0,
      isSavedByParent: result["isSavedByParent"] != 0,
      id: result["id"] as int,
    );
  }

  static Map<String, dynamic> _getNpcMap(
    SavedEntity<Npc> npc, {
    int? importantIn,
    int? notableMemberOf,
    int? rulerOf,
    int? importantInWorld,
  }) =>
      {
        "isSaved": npc.isSaved ? 1 : 0,
        "isSavedByParent": npc.isSavedByParent ? 1 : 0,
        "name": npc.entity.name,
        "age": npc.entity.age,
        "gender": npc.entity.gender.name,
        "race": npc.entity.race.getName(),
        "occupation": npc.entity.occupation,
        "hairstyleLength": npc.entity.physicalDescription.hairStyle.length,
        "hairstyleType": npc.entity.physicalDescription.hairStyle.type,
        "hairstyleColor": npc.entity.physicalDescription.hairStyle.color,
        "eyes": npc.entity.physicalDescription.eyes,
        "skin": npc.entity.physicalDescription.skin,
        "height": npc.entity.physicalDescription.height,
        "build": npc.entity.physicalDescription.build,
        "face": npc.entity.physicalDescription.face,
        "beardLength": npc.entity.physicalDescription.beard?.length,
        "beardType": npc.entity.physicalDescription.beard?.type,
        "beardColor": npc.entity.physicalDescription.beard?.color,
        "specialFeatures":
            jsonEncode(npc.entity.physicalDescription.specialFeatures),
        "alignmentEthical": npc.entity.personality.alignment.ethical.name,
        "alignmentMoral": npc.entity.personality.alignment.moral.name,
        "traits": jsonEncode(npc.entity.personality.traits),
        "quirks": jsonEncode(npc.entity.personality.quirks),
        "descriptors": jsonEncode(npc.entity.personality.descriptors),
        "goal": npc.entity.goal,
        "importantIn": importantIn,
        "notableMemberOf": notableMemberOf,
        "rulerOf": rulerOf,
        "importantInWorld": importantInWorld,
      };

  static Npc _getNpcEntity(Map<String, dynamic> dbMap) {
    final map = Map<String, dynamic>.from(dbMap);
    map["hairStyle"] = {
      "type": map["hairstyleType"],
      "length": map["hairstyleLength"],
      "color": map["hairstyleColor"],
    };

    if (map["beardLength"] == null) {
      map["beard"] = null;
    } else {
      map["beard"] = {
        "type": map["beardType"],
        "length": map["beardLength"],
        "color": map["beardColor"],
      };
    }
    map["ethical"] = map["alignmentEthical"];
    map["moral"] = map["alignmentMoral"];
    map["alignment"] = Alignment.fromMap(map).toMap();
    map["specialFeatures"] = jsonDecode(map["specialFeatures"]);
    map["traits"] = jsonDecode(map["traits"]);
    map["quirks"] = jsonDecode(map["quirks"]);
    map["descriptors"] = jsonDecode(map["descriptors"]);

    map["physicalDescription"] = PhysicalDescription.fromMap(map).toMap();
    map["personality"] = Personality.fromMap(map).toMap();
    return Npc.fromMap(map);
  }
}
