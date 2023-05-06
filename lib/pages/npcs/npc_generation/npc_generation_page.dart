import 'package:flutter/material.dart';
import 'package:randpg/entities/npcs.dart';
import 'package:randpg/entities/races.dart';
import 'package:randpg/generators.dart';
import 'package:randpg/string_manipulations.dart';
import 'package:realm_roller/custom_widgets/dropdowns/dropdown.dart';
import 'package:realm_roller/custom_widgets/generator_pages/generator_page.dart';
import 'package:realm_roller/pages/npcs/npc_view/npc_view.dart';

/// A page used to generate npcs
class NpcGenerationPage extends StatefulWidget {
  const NpcGenerationPage({super.key});

  @override
  State<NpcGenerationPage> createState() => _NpcGenerationPageState();
}

class _NpcGenerationPageState extends State<NpcGenerationPage> {
  String currentRace = "Random";

  void onRaceChange(String? value) {
    if (value != null) {
      setState(() {
        currentRace = value;
      });
    }
  }

  void onGenerate(BuildContext context) {
    final race = currentRace == "Random"
        ? ListItemGenerator(RaceManager.activeRaces).generate()
        : RaceManager.getRaceByName(currentRace.toLowerCase());

    final npc = NpcGenerator(race).generate();

    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => NpcView(npc: npc)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: GeneratorPage(
          title: "Npc Generator",
          onGenerate: () => onGenerate(context),
          children: [
            Dropdown(
              title: "Race:",
              icon: Icons.groups,
              currentValue: currentRace,
              onChanged: onRaceChange,
              options: [
                "Random",
                ...RaceManager.activeRaces.map((e) => titledEach(e.getName()))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
