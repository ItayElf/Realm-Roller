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

    _setupTypes();
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

  static List<T> getAvailableTypes<T>(Manager<T> manager) {
    if (!managersToPaths.containsKey(manager)) {
      throw Exception("No path to manager ${manager.runtimeType}");
    }
    final key = managersToPaths[manager]!;
    final available = localStorage.getStringList(key);

    if (available == null) {
      final list = manager.allTypes.map(_getTypeKey).toList();
      localStorage.setStringList(key, list);
      return manager.allTypes;
    }

    return available.map(manager.getType).toList();
  }

  static void registerType(dynamic type) {
    Manager manager;
    if (type is SvgWrapper) {
      manager = _getSvgManager(type);
    } else {
      if (!typesToManagers.containsKey(type.runtimeType)) {
        throw Exception("Cannot register type ${type.runtimeType}");
      }
      manager = typesToManagers[type.runtimeType]!;
    }
    final key = managersToPaths[manager]!;
    final types = getAvailableTypes(manager);

    manager.registerType(type);
    types.add(type);

    localStorage.setStringList(key, types.map(_getTypeKey).toList());
  }

  static unregisterType(dynamic type) {
    Manager manager;
    if (type is SvgWrapper) {
      manager = _getSvgManager(type);
    } else {
      if (!typesToManagers.containsKey(type.runtimeType)) {
        throw Exception("Cannot register type ${type.runtimeType}");
      }
      manager = typesToManagers[type.runtimeType]!;
    }
    final key = managersToPaths[manager]!;
    final types = getAvailableTypes(manager);

    manager.unregisterType(type);
    types.remove(type);

    localStorage.setStringList(key, types.map(_getTypeKey).toList());
  }

  static Manager<SvgWrapper> _getSvgManager(SvgWrapper type) {
    if (const EmblemShapesManager().allTypes.contains(type)) {
      return const EmblemShapesManager();
    } else if (const EmblemPatternsManager().allTypes.contains(type)) {
      return const EmblemPatternsManager();
    } else if (const EmblemIconsManager().allTypes.contains(type)) {
      return const EmblemIconsManager();
    }
    throw Exception("No manager for svgWrapper $type");
  }

  static void _setupTypes() {
    for (final manager in managersToPaths.keys) {
      final availableTypes = getAvailableTypes(manager);

      manager.activeTypes.forEach(manager.unregisterType);

      availableTypes.forEach(manager.registerType);
    }
  }

  static String _getTypeKey(dynamic type) {
    if (type is DeityType) {
      return type.getDeityType();
    }
    if (type is EmblemType) {
      return type.getEmblemType();
    }
    if (type is GuildType) {
      return type.getGuildType();
    }
    if (type is KingdomType) {
      return type.getKingdomType();
    }
    if (type is GovernmentType) {
      return type.getGovernmentType();
    }
    if (type is LandscapeType) {
      return type.getLandscapeType();
    }
    if (type is LocationType) {
      return type.getLocationType();
    }
    if (type is Race) {
      return type.getName();
    }
    if (type is SettlementType) {
      return type.getSettlementType();
    }
    if (type is WorldSettings) {
      return type.getSettingName();
    }
    if (type is WorldLoreType) {
      return type.getLoreType();
    }
    if (type is SvgWrapper) {
      return type.name;
    }
    throw Exception("Cannot get key of type ${type.runtimeType}");
  }
}
