import 'package:randpg/entities/deities.dart';
import 'package:randpg/entities/emblems.dart';
import 'package:randpg/entities/guilds.dart';
import 'package:randpg/entities/kingdoms.dart';
import 'package:randpg/entities/landscapes.dart';
import 'package:randpg/entities/npcs.dart';
import 'package:randpg/entities/settlements.dart';
import 'package:randpg/entities/worlds.dart';
import 'package:realm_roller/assets_handlers/entities_saver/saveable.dart';
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
  World: "Worlds"
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
    fromJson: NamesData.fromJson,
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