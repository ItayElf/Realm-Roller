import 'package:flutter/material.dart';
import 'package:realm_roller/pages/deities/deity_generation/deity_generation_page.dart';
import 'package:realm_roller/pages/emblem/emblem_generation/emblem_generation_page.dart';
import 'package:realm_roller/pages/guilds/guild_generation/guild_generation_page.dart';
import 'package:realm_roller/pages/kingdoms/kingdom_generation/kingdom_generation_page.dart';
import 'package:realm_roller/pages/landscapes/landscape_generation/landscape_generation_page.dart';
import 'package:realm_roller/pages/locations/locations_generation/location_generation_page.dart';
import 'package:realm_roller/pages/names/names_generation/npc_names_generation_page.dart';
import 'package:realm_roller/pages/names/names_generation/settlement_name_generation.dart';
import 'package:realm_roller/pages/npcs/npc_generation/npc_generation_page.dart';
import 'package:realm_roller/pages/settlements/settlements_generation/settlement_generation_page.dart';
import 'package:realm_roller/pages/worlds/world_generation/world_generation_page.dart';

class GeneratorData {
  const GeneratorData({
    required this.generatorPage,
    required this.title,
    required this.icon,
  });

  final Widget generatorPage;
  final String title;
  final IconData icon;
}

const Map<String, GeneratorData> generatorsData = {
  "Npcs": GeneratorData(
    title: "Npcs",
    icon: Icons.person,
    generatorPage: NpcGenerationPage(),
  ),
  "Names": GeneratorData(
    title: "Names",
    icon: Icons.badge,
    generatorPage: NpcNamesGenerationPage(),
  ),
  "Locations": GeneratorData(
    title: "Locations",
    icon: Icons.location_on,
    generatorPage: LocationGenerationPage(),
  ),
  "Settlements": GeneratorData(
    title: "Settlements",
    icon: Icons.location_city,
    generatorPage: SettlementGenerationPage(),
  ),
  "Settlement Names": GeneratorData(
    title: "Settlement Names",
    icon: Icons.directions,
    generatorPage: SettlementNamesGenerationPage(),
  ),
  "Landscapes": GeneratorData(
    title: "Landscapes",
    icon: Icons.landscape,
    generatorPage: LandscapeGenerationPage(),
  ),
  "Deities": GeneratorData(
    title: "Deities",
    icon: Icons.self_improvement,
    generatorPage: DeityGenerationPage(),
  ),
  "Guilds": GeneratorData(
    title: "Guilds",
    icon: Icons.diversity_3,
    generatorPage: GuildGenerationPage(),
  ),
  "Kingdoms": GeneratorData(
    title: "Kingdoms",
    icon: Icons.gavel,
    generatorPage: KingdomGenerationPage(),
  ),
  "Companions": GeneratorData(
    title: "Companions",
    icon: Icons.pets,
    generatorPage: Placeholder(),
  ),
  "Emblems": GeneratorData(
    title: "Emblems",
    icon: Icons.shield,
    generatorPage: EmblemGenerationPage(),
  ),
  "Worlds": GeneratorData(
    title: "Worlds",
    icon: Icons.public,
    generatorPage: WorldGenerationPage(),
  ),
};
