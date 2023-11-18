import 'dart:convert';

import 'package:randpg/entities/worlds.dart';
import 'package:realm_roller/assets_handlers/sqlite/db_manager.dart';
import 'package:realm_roller/assets_handlers/sqlite/orm/deity_orm.dart';
import 'package:realm_roller/assets_handlers/sqlite/orm/guild_orm.dart';
import 'package:realm_roller/assets_handlers/sqlite/orm/kingdom_orm.dart';
import 'package:realm_roller/assets_handlers/sqlite/orm/landscape_orm.dart';
import 'package:realm_roller/assets_handlers/sqlite/orm/npc_orm.dart';
import 'package:realm_roller/assets_handlers/sqlite/orm/saveable_entity.dart';

/// An orm for the world entity
class WorldOrm {
  static const _tableName = "worlds";

  static Future<int> insertWorld(SaveableEntity<World> world) async {
    final stopwatch2 = Stopwatch()..start();
    final id = await DBManager.database.insert(_tableName, _getWorldMap(world));

    final List<Future> futures = [];

    for (final kingdom in world.entity.kingdoms) {
      futures.add(
        KingdomOrm.insertKingdom(
          SaveableEntity(
            entity: kingdom,
            isSaved: false,
            isSavedByParent: true,
          ),
          locatedIn: id,
        ),
      );
    }
    for (final landscape in world.entity.landscapes) {
      futures.add(
        LandscapeOrm.insertLandscape(
          SaveableEntity(
            entity: landscape,
            isSaved: false,
            isSavedByParent: true,
          ),
          locatedIn: id,
        ),
      );
    }
    for (final npc in world.entity.importantPeople) {
      futures.add(
        NpcOrm.insertNpc(
          SaveableEntity(
            entity: npc,
            isSaved: false,
            isSavedByParent: true,
          ),
          importantInWorld: id,
        ),
      );
    }

    for (final guild in world.entity.guilds) {
      futures.add(
        GuildOrm.insertGuild(
          SaveableEntity(
            entity: guild,
            isSaved: false,
            isSavedByParent: true,
          ),
          locatedInWorld: id,
        ),
      );
    }

    for (final deity in world.entity.deities) {
      futures.add(
        DeityOrm.insertDeity(
          SaveableEntity(
            entity: deity,
            isSaved: false,
            isSavedByParent: true,
          ),
          deityIn: id,
        ),
      );
    }

    for (final deity in world.entity.lesserDeities) {
      futures.add(
        DeityOrm.insertDeity(
          SaveableEntity(
            entity: deity,
            isSaved: false,
            isSavedByParent: true,
          ),
          lesserDeityIn: id,
        ),
      );
    }

    for (final deity in world.entity.higherDeities) {
      futures.add(
        DeityOrm.insertDeity(
          SaveableEntity(
            entity: deity,
            isSaved: false,
            isSavedByParent: true,
          ),
          higherDeityIn: id,
        ),
      );
    }

    await Future.wait(futures);
    print(
        "Total: ${stopwatch2.elapsedMilliseconds} MS, kingdoms: ${world.entity.kingdoms.length}");
    return id;
  }

  static Future<void> updateWorld(
    int id,
    SaveableEntity<World> newWorld,
  ) async {
    await DBManager.database.update(
      _tableName,
      _getWorldMap(newWorld),
      where: "id = ?",
      whereArgs: [id],
    );
  }

  static Future<List<SaveableEntity<World>>> getSavedWorlds() async {
    return queryWorlds("isSaved = ?", whereArgs: [1]);
  }

  static Future<List<SaveableEntity<World>>> queryWorlds(
    String where, {
    List<Object?>? whereArgs,
  }) async {
    final result = await DBManager.database.query(
      _tableName,
      where: where,
      whereArgs: whereArgs,
    );

    final List<SaveableEntity<World>> list = [];
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

  static Future<void> deleteWorld(int id) async {
    await DBManager.database.delete(
      _tableName,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  static Map<String, dynamic> _getWorldMap(SaveableEntity<World> world) {
    final map = world.entity.toMap();
    map["isSaved"] = world.isSaved ? 1 : 0;
    map["opinions"] = jsonEncode(map["opinions"]);
    map["worldLore"] = jsonEncode(map["worldLore"]);
    map.remove("kingdoms");
    map.remove("landscapes");
    map.remove("importantPeople");
    map.remove("guilds");
    map.remove("deities");
    map.remove("lesserDeities");
    map.remove("higherDeities");
    return map;
  }

  static Future<World> _getGuildEntity(Map<String, dynamic> dbMap) async {
    final map = Map<String, dynamic>.from(dbMap);
    map["opinions"] = jsonDecode(map["opinions"]);
    map["worldLore"] = jsonDecode(map["worldLore"]);
    map["kingdoms"] = (await KingdomOrm.queryKingdoms(
      "locatedIn = ?",
      whereArgs: [map["id"]],
    ))
        .map((e) => e.entity.toMap())
        .toList();
    map["landscapes"] = (await LandscapeOrm.queryLandscapes(
      "locatedIn = ?",
      whereArgs: [map["id"]],
    ))
        .map((e) => e.entity.toMap())
        .toList();
    map["importantPeople"] = (await NpcOrm.queryNpcs(
      "importantInWorld = ?",
      whereArgs: [map["id"]],
    ))
        .map((e) => e.entity.toMap())
        .toList();
    map["guilds"] = (await GuildOrm.queryGuilds(
      "locatedInWorld = ?",
      whereArgs: [map["id"]],
    ))
        .map((e) => e.entity.toMap())
        .toList();
    map["deities"] = (await DeityOrm.queryDeities(
      "deityIn = ?",
      whereArgs: [map["id"]],
    ))
        .map((e) => e.entity.toMap())
        .toList();
    map["lesserDeities"] = (await DeityOrm.queryDeities(
      "lesserDeityIn = ?",
      whereArgs: [map["id"]],
    ))
        .map((e) => e.entity.toMap())
        .toList();
    map["higherDeities"] = (await DeityOrm.queryDeities(
      "higherDeityIn = ?",
      whereArgs: [map["id"]],
    ))
        .map((e) => e.entity.toMap())
        .toList();

    return World.fromMap(map);
  }
}
