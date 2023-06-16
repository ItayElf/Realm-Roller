import 'package:flutter/material.dart';
import 'package:randpg/entities/kingdoms.dart';
import 'package:randpg/entities/races.dart';
import 'package:randpg/generators.dart';
import 'package:randpg/string_manipulations.dart';
import 'package:realm_roller/custom_widgets/generator_pages/generator_page.dart';
import 'package:realm_roller/custom_widgets/route_builder/route_builder.dart';
import 'package:realm_roller/pages/kingdoms/kingdom_view/kingdom_view.dart';

import '../../../custom_widgets/dropdowns/dropdown.dart';

/// The page for generating kingdoms
class KingdomGenerationPage extends StatefulWidget {
  const KingdomGenerationPage({super.key});

  @override
  State<KingdomGenerationPage> createState() => _KingdomGenerationPageState();
}

class _KingdomGenerationPageState extends State<KingdomGenerationPage> {
  String currentRace = "Random";
  String currentGovernment = "Random";

  void onGenerate(BuildContext context) {
    final governmentType = currentGovernment == "Random"
        ? ListItemGenerator(const GovernmentTypeManager().activeTypes)
            .generate()
        : const GovernmentTypeManager()
            .getType(currentGovernment.toLowerCase());

    final race = currentRace == "Random"
        ? ListItemGenerator(const RaceManager().activeTypes).generate()
        : const RaceManager().getType(currentRace.toLowerCase());

    final kingdom =
        KingdomGenerator(const DefaultKingdomType(), race, governmentType)
            .generate();

    Navigator.of(context).push(buildRoute(KingdomView(kingdom: kingdom)));
  }

  void onSettlementChange(String? value) {
    setState(() {
      currentGovernment = value ?? currentGovernment;
    });
  }

  void onRaceChange(String? value) {
    setState(() {
      currentRace = value ?? currentRace;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: GeneratorPage(
          title: "Kingdom Generator",
          onGenerate: () => onGenerate(context),
          children: [
            Dropdown(
              title: "Race:",
              icon: Icons.groups,
              currentValue: currentRace,
              onChanged: onRaceChange,
              options: [
                "Random",
                ...const RaceManager()
                    .activeTypes
                    .map((e) => titledEach(e.getName()))
              ],
            ),
            const SizedBox(height: 28),
            Dropdown(
              title: "Government Type:",
              icon: Icons.gavel,
              currentValue: currentGovernment,
              onChanged: onSettlementChange,
              options: [
                "Random",
                ...const GovernmentTypeManager()
                    .activeTypes
                    .map((e) => titledEach(e.getGovernmentType()))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
