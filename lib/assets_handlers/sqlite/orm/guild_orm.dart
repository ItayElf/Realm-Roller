import 'dart:convert';

import 'package:randpg/entities/guilds.dart';
import 'package:realm_roller/assets_handlers/sqlite/db_manager.dart';
import 'package:realm_roller/assets_handlers/sqlite/orm/emblem_orm.dart';
import 'package:realm_roller/assets_handlers/sqlite/orm/npc_orm.dart';
import 'package:realm_roller/assets_handlers/sqlite/orm/saveable_entity.dart';

/// An orm for guilds
class GuildOrm {
  static const _tableName = "guilds";

  static Future<int> insertGuild(
    SaveableEntity<Guild> guild, {
    int? locatedIn,
    int? locatedInWorld,
  }) async {
    final id = await DBManager.database.insert(
      _tableName,
      await _getGuildMap(
        guild,
        locatedIn: locatedIn,
        locatedInWorld: locatedInWorld,
      ),
    );

    for (final npc in guild.entity.notableMembers) {
      await NpcOrm.insertNpc(
        SaveableEntity(
          entity: npc,
          isSaved: false,
          isSavedByParent: true,
        ),
        notableMemberOf: id,
      );
    }

    return id;
  }

  static Future<void> updateGuild(
    int id,
    SaveableEntity<Guild> newGuild, {
    int? locatedIn,
    int? locatedInWorld,
  }) async {
    await DBManager.database.execute(
      "DELETE FROM npcs WHERE id IN (SELECT leaderId FROM guilds WHERE id = ?)",
      [id],
    );
    await DBManager.database.execute(
      "DELETE FROM emblems WHERE id IN (SELECT emblemId FROM guilds WHERE id = ?)",
      [id],
    );
    await DBManager.database.update(
      _tableName,
      await _getGuildMap(
        newGuild,
        locatedIn: locatedIn,
        locatedInWorld: locatedInWorld,
      ),
      where: "id = ?",
      whereArgs: [id],
    );
  }

  static Future<void> deleteGuild(int id) async {
    await DBManager.database.execute(
      "DELETE FROM npcs WHERE id IN (SELECT leaderId FROM guilds WHERE id = ?)",
      [id],
    );
    await DBManager.database.execute(
      "DELETE FROM emblems WHERE id IN (SELECT emblemId FROM guilds WHERE id = ?)",
      [id],
    );
    await DBManager.database.delete(
      _tableName,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  static Future<List<SaveableEntity<Guild>>> getSavedGuilds() async {
    return queryGuilds("isSaved = ?", whereArgs: [1]);
  }

  static Future<List<SaveableEntity<Guild>>> queryGuilds(
    String where, {
    List<Object?>? whereArgs,
  }) async {
    final result = await DBManager.database.query(
      _tableName,
      where: where,
      whereArgs: whereArgs,
    );

    final List<SaveableEntity<Guild>> list = [];
    for (final map in result) {
      list.add(SaveableEntity(
        entity: await _getGuildEntity(map),
        isSaved: map["isSaved"] != 0,
        isSavedByParent: map["isSavedByParent"] != 0,
        id: map["id"] as int,
      ));
    }

    return list;
  }

  static Future<Map<String, dynamic>> _getGuildMap(
    SaveableEntity<Guild> guild, {
    int? locatedIn,
    int? locatedInWorld,
  }) async {
    final map = guild.entity.toMap();
    map["isSaved"] = guild.isSaved ? 1 : 0;
    map["isSavedByParent"] = guild.isSavedByParent ? 1 : 0;
    map["locatedIn"] = locatedIn;
    map["locatedInWorld"] = locatedInWorld;
    map["specialties"] = jsonEncode(map["specialties"]);
    map["quests"] = jsonEncode(map["quests"]);
    map["leaderId"] = await NpcOrm.insertNpc(
      SaveableEntity(
        entity: guild.entity.leader,
        isSaved: false,
        isSavedByParent: true,
      ),
    );
    map["emblemId"] = await EmblemOrm.insertEmblem(
      SaveableEntity(
        entity: guild.entity.emblem,
        isSaved: false,
        isSavedByParent: true,
      ),
    );
    map.remove("leader");
    map.remove("emblem");
    map.remove("notableMembers");

    return map;
  }

  static Future<Guild> _getGuildEntity(Map<String, dynamic> dbMap) async {
    final map = Map<String, dynamic>.from(dbMap);
    map["leader"] = (await NpcOrm.getNpcById(map["leaderId"])).entity.toMap();
    map["emblem"] =
        (await EmblemOrm.getEmblemById(map["emblemId"])).entity.toMap();
    map["specialties"] = jsonDecode(map["specialties"]);
    map["quests"] = jsonDecode(map["quests"]);
    map["notableMembers"] = (await NpcOrm.queryNpcs(
      "notableMemberOf = ?",
      whereArgs: [map["id"]],
    ))
        .map((e) => e.entity.toMap())
        .toList();
    return Guild.fromMap(map);
  }
}
