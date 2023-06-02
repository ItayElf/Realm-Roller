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

final Map<String, GeneratorData> generatorsData = {
  "Npc": const GeneratorData(
    title: "Npc",
    icon: Icons.person,
    generatorPage: NpcGenerationPage(),
  ),
  "Names": const GeneratorData(
    title: "Names",
    icon: Icons.badge,
    generatorPage: NpcNamesGenerationPage(),
  ),
  "Locations": const GeneratorData(
    title: "Locations",
    icon: Icons.location_on,
    generatorPage: LocationGenerationPage(),
  ),
  "Settlements": const GeneratorData(
    title: "Settlements",
    icon: Icons.location_city,
    generatorPage: SettlementGenerationPage(),
  ),
  "Settlement Names": const GeneratorData(
    title: "Settlement Names",
    icon: Icons.location_city,
    generatorPage: SettlementNamesGenerationPage(),
  ),
  "Landscapes": const GeneratorData(
    title: "Landscapes",
    icon: Icons.landscape,
    generatorPage: LandscapeGenerationPage(),
  ),
  "Deities": const GeneratorData(
    title: "Deities",
    icon: Icons.self_improvement,
    generatorPage: DeityGenerationPage(),
  ),
  "Guilds": const GeneratorData(
    title: "Guilds",
    icon: Icons.diversity_3,
    generatorPage: GuildGenerationPage(),
  ),
  "Kingdoms": const GeneratorData(
    title: "Kingdoms",
    icon: Icons.gavel,
    generatorPage: KingdomGenerationPage(),
  ),
  "Emblems": const GeneratorData(
    title: "Emblems",
    icon: Icons.shield,
    generatorPage: EmblemGenerationPage(),
  ),
  "Worlds": const GeneratorData(
    title: "Worlds",
    icon: Icons.shield,
    generatorPage: WorldGenerationPage(),
  ),
};
