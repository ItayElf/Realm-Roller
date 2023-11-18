import 'dart:convert';

import 'package:randpg/entities/npcs.dart';
import 'package:realm_roller/assets_handlers/sqlite/db_manager.dart';
import 'package:realm_roller/assets_handlers/sqlite/orm/saveable_entity.dart';

/// Orm for npcs
class NpcOrm {
  static const _tableName = "npcs";

  static Future<int> insertNpc(
    SaveableEntity<Npc> npc, {
    int? importantIn,
    int? notableMemberOf,
    int? rulerOf,
    int? importantInWorld,
  }) async {
    return DBManager.database.insert(
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
    SaveableEntity<Npc> newNpc, {
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

  static Future<List<SaveableEntity<Npc>>> getSavedNpcs() async {
    return queryNpcs("isSaved = ?", whereArgs: [1]);
  }

  static Future<List<SaveableEntity<Npc>>> queryNpcs(
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
          entity: _getNpcEntity(map),
          isSaved: map["isSaved"] != 0,
          isSavedByParent: map["isSavedByParent"] != 0,
          id: map["id"] as int,
        );
      },
    );
  }

  static Future<SaveableEntity<Npc>> getNpcById(int id) async {
    final result = (await DBManager.database.query(
      _tableName,
      where: "id = ?",
      whereArgs: [id],
    ))[0];

    return SaveableEntity(
      entity: _getNpcEntity(result),
      isSaved: result["isSaved"] != 0,
      isSavedByParent: result["isSavedByParent"] != 0,
      id: result["id"] as int,
    );
  }

  static Map<String, dynamic> _getNpcMap(
    SaveableEntity<Npc> npc, {
    int? importantIn,
    int? notableMemberOf,
    int? rulerOf,
    int? importantInWorld,
  }) {
    final entity = npc.entity;
    return {
      "isSaved": npc.isSaved ? 1 : 0,
      "isSavedByParent": npc.isSavedByParent ? 1 : 0,
      "name": entity.name,
      "age": entity.age,
      "gender": entity.gender.name,
      "race": entity.race.getName(),
      "occupation": entity.occupation,
      "hairstyleLength": entity.physicalDescription.hairStyle.length,
      "hairstyleType": entity.physicalDescription.hairStyle.type,
      "hairstyleColor": entity.physicalDescription.hairStyle.color,
      "eyes": entity.physicalDescription.eyes,
      "skin": entity.physicalDescription.skin,
      "height": entity.physicalDescription.height,
      "build": entity.physicalDescription.build,
      "face": entity.physicalDescription.face,
      "beardLength": entity.physicalDescription.beard?.length,
      "beardType": entity.physicalDescription.beard?.type,
      "beardColor": entity.physicalDescription.beard?.color,
      "specialFeatures": jsonEncode(entity.physicalDescription.specialFeatures),
      "alignmentEthical": entity.personality.alignment.ethical.name,
      "alignmentMoral": entity.personality.alignment.moral.name,
      "traits": jsonEncode(entity.personality.traits),
      "quirks": jsonEncode(entity.personality.quirks),
      "descriptors": jsonEncode(entity.personality.descriptors),
      "goal": entity.goal,
      "importantIn": importantIn,
      "notableMemberOf": notableMemberOf,
      "rulerOf": rulerOf,
      "importantInWorld": importantInWorld,
    };
  }

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
