import 'package:flutter/material.dart';
import 'package:randpg/entities/locations.dart';
import 'package:randpg/entities/races.dart';
import 'package:randpg/entities/settlements.dart';
import 'package:randpg/generators.dart';
import 'package:randpg/string_manipulations.dart';
import 'package:realm_roller/custom_widgets/generator_pages/generator_page.dart';
import 'package:realm_roller/custom_widgets/route_builder/route_builder.dart';
import 'package:realm_roller/pages/locations/location_view/location_view.dart';

import '../../../custom_widgets/dropdowns/dropdown.dart';

/// The page for generating settlements
class SettlementGenerationPage extends StatefulWidget {
  const SettlementGenerationPage({super.key});

  @override
  State<SettlementGenerationPage> createState() =>
      _SettlementGenerationPageState();
}

class _SettlementGenerationPageState extends State<SettlementGenerationPage> {
  String currentSettlement = "Random";
  String currentRace = "Random";

  void onGenerate(BuildContext context) {
    final settlementType = currentSettlement == "Random"
        ? ListItemGenerator(SettlementManager.activeSettlementTypes).generate()
        : SettlementManager.getSettlementTypeByType(
            currentSettlement.toLowerCase());

    final race = currentRace == "Random"
        ? ListItemGenerator([...RaceManager.activeRaces, null]).generate()
        : currentRace == "None"
            ? null
            : RaceManager.getRaceByName(currentRace.toLowerCase());

    final settlement = SettlementGenerator(settlementType, race).generate();

    print(settlement);
  }

  void onSettlementChange(String? value) {
    setState(() {
      currentSettlement = value ?? currentSettlement;
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
          title: "Settlement Generator",
          onGenerate: () => onGenerate(context),
          children: [
            Dropdown(
              title: "Settlement:",
              icon: Icons.location_city,
              currentValue: currentSettlement,
              onChanged: onSettlementChange,
              options: [
                "Random",
                ...SettlementManager.activeSettlementTypes
                    .map((e) => titledEach(e.getSettlementType()))
              ],
            ),
            const SizedBox(height: 28),
            Dropdown(
              title: "Dominant Race:",
              icon: Icons.groups,
              currentValue: currentRace,
              onChanged: onRaceChange,
              options: [
                "Random",
                "None",
                ...RaceManager.activeRaces.map((e) => titledEach(e.getName()))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
