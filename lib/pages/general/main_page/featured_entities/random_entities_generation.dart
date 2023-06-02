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
        ListItemGenerator(RaceManager.activeRaces).generate(),
      ),
  () => LocationGenerator(
        ListItemGenerator(LocationManager.activeLocationTypes).generate(),
        ListItemGenerator(RaceManager.activeRaces).generate(),
      ),
  () => SettlementGenerator(
        ListItemGenerator(SettlementManager.activeSettlementTypes).generate(),
        ListItemGenerator(RaceManager.activeRaces).generate(),
      ),
  () => LandscapeGenerator(
        ListItemGenerator(LandscapeManager.activeLandscapeTypes).generate(),
      ),
  () => DeityGenerator(
        ListItemGenerator(DeityManager.activeDeityTypes).generate(),
        BaseAlignmentGenerator().generate(),
      ),
  () => GuildGenerator(
      ListItemGenerator(GuildManager.activeGuildTypes).generate()),
  () => KingdomGenerator(
        ListItemGenerator(KingdomTypeManager.activeKingdomTypes).generate(),
        ListItemGenerator(RaceManager.activeRaces).generate(),
        ListItemGenerator(GovernmentTypeManager.activeGovernmentTypes)
            .generate(),
      ),
  () => EmblemGenerator(
        ListItemGenerator(EmblemTypeManager.activeEmblemTypes).generate(),
      ),
  () => WorldGenerator(
        ListItemGenerator(WorldSettingsManager.activeWorldSettings).generate(),
      ),
];

List getRandomEntities(int count) =>
    RepeatedGenerator(ListItemGenerator(_entitiesGenerationFunctions), count)
        .generate()
        .map((generationFunction) => generationFunction().generate())
        .toList();
