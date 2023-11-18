import 'package:randpg/entities/kingdoms.dart';
import 'package:realm_roller/assets_handlers/sqlite/db_manager.dart';
import 'package:realm_roller/assets_handlers/sqlite/orm/emblem_orm.dart';
import 'package:realm_roller/assets_handlers/sqlite/orm/guild_orm.dart';
import 'package:realm_roller/assets_handlers/sqlite/orm/npc_orm.dart';
import 'package:realm_roller/assets_handlers/sqlite/orm/saveable_entity.dart';
import 'package:realm_roller/assets_handlers/sqlite/orm/settlement_orm.dart';

/// An orm for kingdoms
class KingdomOrm {
  static const _tableName = "kingdoms";

  static Future<int> insertKingdom(
    SaveableEntity<Kingdom> kingdom, {
    int? locatedIn,
  }) async {
    final id = await DBManager.database.insert(
      _tableName,
      await _getKingdomMap(
        kingdom,
        locatedIn: locatedIn,
      ),
    );

    for (final npc in kingdom.entity.rulers) {
      await NpcOrm.insertNpc(
        SaveableEntity(
          entity: npc,
          isSaved: false,
          isSavedByParent: true,
        ),
        rulerOf: id,
      );
    }

    for (final settlement in kingdom.entity.importantSettlements) {
      await SettlementOrm.insertSettlement(
        SaveableEntity(
          entity: settlement,
          isSaved: false,
          isSavedByParent: true,
        ),
        importantIn: id,
      );
    }

    for (final guild in kingdom.entity.guilds) {
      await GuildOrm.insertGuild(
        SaveableEntity(
          entity: guild,
          isSaved: false,
          isSavedByParent: true,
        ),
        locatedIn: id,
      );
    }

    return id;
  }

  static Future<void> updateKingdom(
    int id,
    SaveableEntity<Kingdom> newKingdom, {
    int? locatedIn,
  }) async {
    await DBManager.database.execute(
      "DELETE FROM settlements WHERE id IN (SELECT capitalId FROM kingdoms WHERE id = ?)",
      [id],
    );
    await DBManager.database.execute(
      "DELETE FROM emblems WHERE id IN (SELECT emblemId FROM kingdoms WHERE id = ?)",
      [id],
    );
    await DBManager.database.update(
      _tableName,
      await _getKingdomMap(
        newKingdom,
        locatedIn: locatedIn,
      ),
      where: "id = ?",
      whereArgs: [id],
    );
  }

  static Future<void> deleteKingdom(int id) async {
    await DBManager.database.execute(
      "DELETE FROM settlements WHERE id IN (SELECT capitalId FROM kingdoms WHERE id = ?)",
      [id],
    );
    await DBManager.database.execute(
      "DELETE FROM emblems WHERE id IN (SELECT emblemId FROM kingdoms WHERE id = ?)",
      [id],
    );
    await DBManager.database.delete(
      _tableName,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  static Future<List<SaveableEntity<Kingdom>>> getSavedKingdoms() async {
    return queryKingdoms("isSaved = ?", whereArgs: [1]);
  }

  static Future<List<SaveableEntity<Kingdom>>> queryKingdoms(
    String where, {
    List<Object?>? whereArgs,
  }) async {
    final result = await DBManager.database.query(
      _tableName,
      where: where,
      whereArgs: whereArgs,
    );

    final List<SaveableEntity<Kingdom>> list = [];
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

  static Future<Map<String, dynamic>> _getKingdomMap(
    SaveableEntity<Kingdom> guild, {
    int? locatedIn,
  }) async {
    final map = guild.entity.toMap();
    map["isSaved"] = guild.isSaved ? 1 : 0;
    map["isSavedByParent"] = guild.isSavedByParent ? 1 : 0;
    map["locatedIn"] = locatedIn;
    map["capitalId"] = await SettlementOrm.insertSettlement(
      SaveableEntity(
        entity: guild.entity.capital,
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
    map.remove("capital");
    map.remove("emblem");
    map.remove("rulers");
    map.remove("importantSettlements");
    map.remove("guilds");

    return map;
  }

  static Future<Kingdom> _getGuildEntity(Map<String, dynamic> dbMap) async {
    final map = Map<String, dynamic>.from(dbMap);
    map["capital"] = (await SettlementOrm.getSettlementById(map["capitalId"]))
        .entity
        .toMap();
    map["emblem"] =
        (await EmblemOrm.getEmblemById(map["emblemId"])).entity.toMap();
    map["rulers"] = (await NpcOrm.queryNpcs(
      "rulerOf = ?",
      whereArgs: [map["id"]],
    ))
        .map((e) => e.entity.toMap())
        .toList();
    map["importantSettlements"] = (await SettlementOrm.querySettlements(
      "importantIn = ?",
      whereArgs: [map["id"]],
    ))
        .map((e) => e.entity.toMap())
        .toList();
    map["guilds"] = (await GuildOrm.queryGuilds(
      "locatedIn = ?",
      whereArgs: [map["id"]],
    ))
        .map((e) => e.entity.toMap())
        .toList();
    return Kingdom.fromMap(map);
  }
}
