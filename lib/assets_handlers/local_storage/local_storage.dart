import 'package:randpg/entities/deities.dart';
import 'package:randpg/entities/emblems.dart';
import 'package:randpg/entities/guilds.dart';
import 'package:randpg/entities/kingdoms.dart';
import 'package:randpg/entities/landscapes.dart';
import 'package:randpg/entities/locations.dart';
import 'package:randpg/entities/races.dart';
import 'package:randpg/entities/settlements.dart';
import 'package:randpg/entities/worlds.dart';
import 'package:randpg/general.dart';
import 'package:realm_roller/assets_handlers/local_storage/saver_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalStorage {
  static late SharedPreferences localStorage;

  static Future init() async {
    localStorage = await SharedPreferences.getInstance();
  }

  static List getEntities(Type type) {
    if (!entitiesToPaths.containsKey(type)) {
      throw Exception("No entities of type $type");
    }
    final entities = localStorage.getStringList(entitiesToPaths[type]!);

    if (entities == null) {
      return [];
    }
    final saveable = entitiesToSaveables[type]!;
    return entities.map(saveable.fromJson).toList();
  }

  static void saveEntity(dynamic entity) {
    final type = entity.runtimeType;

    final entities = getEntities(type);
    final saveable = entitiesToSaveables[type]!;

    if (!entities.contains(entity)) {
      entities.add(entity);
    }

    localStorage.setStringList(
      entitiesToPaths[type]!,
      entities.map<String>(saveable.toJson).toList(),
    );
  }

  static void deleteEntity(dynamic entity) {
    final type = entity.runtimeType;

    final entities = getEntities(type)..remove(entity);
    final saveable = entitiesToSaveables[type]!;

    localStorage.setStringList(
      entitiesToPaths[type]!,
      entities.map<String>(saveable.toJson).toList(),
    );
  }

  static bool isEntitySaved(dynamic entity) {
    final type = entity.runtimeType;
    final entities = getEntities(type);
    return entities.contains(entity);
  }

  static getAvailableTypes(Manager manager) {
    if (!managersToPaths.containsKey(manager)) {
      throw Exception("No path to manager ${manager.runtimeType}");
    }
    final key = managersToPaths[manager]!;
    final available = localStorage.getStringList(key);

    if (available == null) {
      final list = manager.allTypes.map(_getTypeKey).toList();
      localStorage.setStringList(key, list);
      return list;
    }

    return available;
  }

  static String _getTypeKey(dynamic type) {
    switch (type.runtimeType) {
      case DeityType:
        return (type as DeityType).getDeityType();
      case EmblemType:
        return (type as EmblemType).getEmblemType();
      case GuildType:
        return (type as GuildType).getGuildType();
      case KingdomType:
        return (type as KingdomType).getKingdomType();
      case GovernmentType:
        return (type as GovernmentType).getGovernmentType();
      case LandscapeType:
        return (type as LandscapeType).getLandscapeType();
      case LocationType:
        return (type as LocationType).getLocationType();
      case Race:
        return (type as Race).getName();
      case SettlementType:
        return (type as SettlementType).getSettlementType();
      case WorldSettings:
        return (type as WorldSettings).getSettingName();
      case WorldLoreType:
        return (type as WorldLoreType).getLoreType();
      case SvgWrapper:
        return (type as SvgWrapper).name;
    }
    throw Exception("Cannot get key of type ${type.runtimeType}");
  }
}
