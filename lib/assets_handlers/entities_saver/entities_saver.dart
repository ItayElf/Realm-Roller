import 'package:randpg/entities/deities.dart';
import 'package:randpg/entities/emblems.dart';
import 'package:randpg/entities/guilds.dart';
import 'package:randpg/entities/kingdoms.dart';
import 'package:randpg/entities/landscapes.dart';
import 'package:randpg/entities/npcs.dart';
import 'package:randpg/entities/settlements.dart';
import 'package:randpg/entities/worlds.dart';
import 'package:realm_roller/assets_handlers/entities_saver/saveable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalStorage {
  static late SharedPreferences localStorage;

  static const Map<Type, String> entitiesToPaths = {
    Npc: "npcs",
    // TODO: add names
    Location: "locations",
    Settlement: "settlements",
    // TODO: add settlement names
    Landscape: "landscapes",
    Deity: "deities",
    Guild: "guilds",
    Kingdom: "kingdoms",
    Emblem: "emblems",
    World: "worlds"
  };

  static final Map<Type, Saveable> entitiesToSaveables = {
    Npc: Saveable(
      fromJson: Npc.fromJson,
      toJson: (e) => ((e as Npc).toJson()),
    ),
    // TODO: add names
    Location: Saveable(
      fromJson: Location.fromJson,
      toJson: (e) => ((e as Location).toJson()),
    ),
    Settlement: Saveable(
      fromJson: Settlement.fromJson,
      toJson: (e) => ((e as Settlement).toJson()),
    ),
    // TODO: add settlement names
    Landscape: Saveable(
      fromJson: Landscape.fromJson,
      toJson: (e) => ((e as Landscape).toJson()),
    ),
    Deity: Saveable(
      fromJson: Deity.fromJson,
      toJson: (e) => ((e as Deity).toJson()),
    ),
    Guild: Saveable(
      fromJson: Guild.fromJson,
      toJson: (e) => ((e as Guild).toJson()),
    ),
    Kingdom: Saveable(
      fromJson: Kingdom.fromJson,
      toJson: (e) => ((e as Kingdom).toJson()),
    ),
    Emblem: Saveable(
      fromJson: Emblem.fromJson,
      toJson: (e) => ((e as Emblem).toJson()),
    ),
    World: Saveable(
      fromJson: World.fromJson,
      toJson: (e) => ((e as World).toJson()),
    )
  };

  static Future init() async {
    localStorage = await SharedPreferences.getInstance();
  }

  static List<T> getEntities<T>() {
    if (!entitiesToPaths.containsKey(T)) {
      throw Exception("No entities of type $T");
    }
    final entities = localStorage.getStringList(entitiesToPaths[T]!);
    if (entities == null) {
      return [];
    }
    final saveable = entitiesToSaveables[T]!;
    return entities.map(saveable.fromJson).toList() as List<T>;
  }

  static void saveEntity(dynamic entity) {
    final type = entity.runtimeType;
    if (!entitiesToPaths.containsKey(type)) {
      throw Exception("No entities of type $type");
    }

    final entities = getEntities();
    final saveable = entitiesToSaveables[type]!;

    localStorage.setStringList(
      entitiesToPaths[type]!,
      entities.map<String>(saveable.toJson).toList(),
    );
  }
}
