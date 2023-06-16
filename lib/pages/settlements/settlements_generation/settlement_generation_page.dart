import 'package:flutter/material.dart';
import 'package:randpg/entities/races.dart';
import 'package:randpg/entities/settlements.dart';
import 'package:randpg/generators.dart';
import 'package:randpg/string_manipulations.dart';
import 'package:realm_roller/custom_widgets/generator_pages/generator_page.dart';
import 'package:realm_roller/custom_widgets/route_builder/route_builder.dart';
import 'package:realm_roller/pages/settlements/settlement_view/settlement_view.dart';

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
        ? ListItemGenerator(const SettlementManager().activeTypes).generate()
        : const SettlementManager().getType(currentSettlement.toLowerCase());

    final race = currentRace == "Random"
        ? ListItemGenerator([...const RaceManager().activeTypes, null])
            .generate()
        : currentRace == "None"
            ? null
            : const RaceManager().getType(currentRace.toLowerCase());

    final settlement = SettlementGenerator(settlementType, race).generate();

    Navigator.of(context)
        .push(buildRoute(SettlementView(settlement: settlement)));
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
                ...const SettlementManager()
                    .activeTypes
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
                ...const RaceManager()
                    .activeTypes
                    .map((e) => titledEach(e.getName()))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
