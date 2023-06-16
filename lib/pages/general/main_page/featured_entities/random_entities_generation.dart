import 'package:randpg/entities/custom/custom_races.dart';
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
import 'package:randpg/generators.dart';

final List<IGenerator Function()> _entitiesGenerationFunctions = [
  () => NpcGenerator(
        ListItemGenerator(const RaceManager().activeTypes).generate(),
      ),
  () => LocationGenerator(
        ListItemGenerator(const LocationManager().activeTypes).generate(),
        ListItemGenerator(const RaceManager().activeTypes).generate(),
      ),
  () => SettlementGenerator(
        ListItemGenerator(const SettlementManager().activeTypes).generate(),
        ListItemGenerator(const RaceManager().activeTypes).generate(),
      ),
  () => LandscapeGenerator(
        ListItemGenerator(const LandscapeManager().activeTypes).generate(),
      ),
  () => DeityGenerator(
        ListItemGenerator(const DeityManager().activeTypes).generate(),
        BaseAlignmentGenerator().generate(),
      ),
  () => GuildGenerator(
      ListItemGenerator(const GuildManager().activeTypes).generate()),
  () => KingdomGenerator(
        ListItemGenerator(const KingdomTypeManager().activeTypes).generate(),
        ListItemGenerator(const RaceManager().activeTypes).generate(),
        ListItemGenerator(const GovernmentTypeManager().activeTypes).generate(),
      ),
  () => EmblemGenerator(
        ListItemGenerator(const EmblemTypeManager().activeTypes).generate(),
      ),
  () => WorldGenerator(
        ListItemGenerator(const WorldSettingsManager().activeTypes).generate(),
      ),
];

List getRandomEntities(int count) =>
    RepeatedGenerator(ListItemGenerator(_entitiesGenerationFunctions), count)
        .generate()
        .map((generationFunction) => generationFunction().generate())
        .toList();
