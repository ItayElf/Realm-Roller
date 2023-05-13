import 'package:flutter/material.dart';
import 'package:realm_roller/custom_widgets/route_builder/route_builder.dart';
import 'package:realm_roller/pages/deities/deities_generation/deitieis_generation_page.dart';
import 'package:realm_roller/pages/landscapes/lanscape_generation/landscape_generation_page.dart';
import 'package:realm_roller/pages/locations/locations_generation/location_generation_page.dart';
import 'package:realm_roller/pages/names/names_generation/npc_names_generation_page.dart';
import 'package:realm_roller/pages/npcs/npc_generation/npc_generation_page.dart';
import 'package:realm_roller/pages/settlements/settlements_generation/settlement_generation_page.dart';

import '../names/names_generation/settlement_name_generation.dart';

/// A widget that lists all the available generators
class GeneratorsPage extends StatelessWidget {
  const GeneratorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    const generators = {
      "Npc": NpcGenerationPage(),
      "Names": NpcNamesGenerationPage(),
      "Locations": LocationGenerationPage(),
      "Settlements": SettlementGenerationPage(),
      "Settlement Names": SettlementNamesGenerationPage(),
      "Landscapes": LandscapeGenerationPage(),
      "Deities": DeitiesGenerationPage(),
    };
    final titles = generators.keys.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Generators"),
        centerTitle: true,
      ),
      body: ListView.separated(
        itemBuilder: (context, i) =>
            _getGeneratorButton(context, titles[i], generators[titles[i]]!),
        separatorBuilder: (context, i) => const SizedBox(
          height: 24,
        ),
        itemCount: titles.length,
      ),
    );
  }

  Widget _getGeneratorButton(
          BuildContext context, String title, Widget generatorPage) =>
      ElevatedButton(
          onPressed: () =>
              Navigator.of(context).push(buildRoute(generatorPage)),
          child: Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge,
          ));
}
