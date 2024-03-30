import 'package:randpg/entities/companions.dart';
import 'package:randpg/entities/deities.dart';
import 'package:randpg/entities/emblems.dart';
import 'package:randpg/entities/guilds.dart';
import 'package:randpg/entities/kingdoms.dart';
import 'package:randpg/entities/landscapes.dart';
import 'package:randpg/entities/locations.dart';
import 'package:randpg/entities/npcs.dart';
import 'package:randpg/entities/races.dart';
import 'package:randpg/entities/settlements.dart';
import 'package:randpg/entities/worlds.dart';
import 'package:randpg/general.dart';
import 'package:realm_roller/assets_handlers/local_storage/saveable.dart';
import 'package:realm_roller/extensions/entities/names_data.dart';

const Map<Type, String> entitiesToPaths = {
  Npc: "Npcs",
  NamesData: "Names",
  Location: "Locations",
  Settlement: "Settlements",
  SettlementNamesData: "Settlement Names",
  Landscape: "Landscapes",
  Deity: "Deities",
  Guild: "Guilds",
  Kingdom: "Kingdoms",
  Emblem: "Emblems",
  World: "Worlds",
  Companion: "Companions",
};

final Map<Type, Saveable> entitiesToSaveables = {
  Npc: Saveable(
    fromJson: Npc.fromJson,
    toJson: (e) => ((e as Npc).toJson()),
  ),
  NamesData: Saveable(
    fromJson: NamesData.fromJson,
    toJson: (e) => ((e as NamesData).toJson()),
  ),
  Location: Saveable(
    fromJson: Location.fromJson,
    toJson: (e) => ((e as Location).toJson()),
  ),
  Settlement: Saveable(
    fromJson: Settlement.fromJson,
    toJson: (e) => ((e as Settlement).toJson()),
  ),
  SettlementNamesData: Saveable(
    fromJson: SettlementNamesData.fromJson,
    toJson: (e) => ((e as SettlementNamesData).toJson()),
  ),
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

const Map<Manager, String> managersToPaths = {
  DeityManager(): "availableDeities",
  EmblemTypeManager(): "availableEmblems",
  EmblemShapesManager(): "availableEmblemsShapes",
  EmblemPatternsManager(): "availableEmblemPatterns",
  EmblemIconsManager(): "availableEmblemIcons",
  GuildManager(): "availableGuilds",
  KingdomTypeManager(): "availableKingdoms",
  GovernmentTypeManager(): "availableGovernments",
  LandscapeManager(): "availableLandscapes",
  LocationManager(): "availableLocations",
  RaceManager(): "availableRaces",
  SettlementManager(): "availableSettlements",
  WorldSettingsManager(): "availableWorldSettings",
  WorldLoreManager(): "availableWorldLores"
};

const Map<Type, Manager> typesToManagers = {
  DeityType: DeityManager(),
  EmblemType: EmblemTypeManager(),
  GuildType: GuildManager(),
  KingdomType: KingdomTypeManager(),
  GovernmentType: GovernmentTypeManager(),
  LandscapeType: LandscapeManager(),
  LocationType: LocationManager(),
  Race: RaceManager(),
  SettlementType: SettlementManager(),
  WorldSettings: WorldSettingsManager(),
  WorldLoreType: WorldLoreManager(),
};

Manager getManager(dynamic type) {
  if (const EmblemShapesManager().allTypes.contains(type)) {
    return const EmblemShapesManager();
  }
  if (const EmblemPatternsManager().allTypes.contains(type)) {
    return const EmblemPatternsManager();
  }
  if (const EmblemIconsManager().allTypes.contains(type)) {
    return const EmblemIconsManager();
  }
  if (type is DeityType) {
    return const DeityManager();
  }
  if (type is EmblemType) {
    return const EmblemTypeManager();
  }
  if (type is GuildType) {
    return const GuildManager();
  }
  if (type is KingdomType) {
    return const KingdomTypeManager();
  }
  if (type is GovernmentType) {
    return const GovernmentTypeManager();
  }
  if (type is LandscapeType) {
    return const LandscapeManager();
  }
  if (type is LocationType) {
    return const LocationManager();
  }
  if (type is Race) {
    return const RaceManager();
  }
  if (type is SettlementType) {
    return const SettlementManager();
  }
  if (type is WorldSettings) {
    return const WorldSettingsManager();
  }
  if (type is WorldLoreType) {
    return const WorldLoreManager();
  }
  throw Exception("Cannot get key of type ${type.runtimeType}");
}

String getTypeKey(dynamic type) {
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
