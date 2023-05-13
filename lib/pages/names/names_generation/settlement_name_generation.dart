import 'package:flutter/material.dart';
import 'package:randpg/entities/races.dart';
import 'package:randpg/entities/settlements.dart';
import 'package:randpg/generators.dart';
import 'package:randpg/string_manipulations.dart';
import 'package:realm_roller/assets_handlers/image_path_finders.dart';
import 'package:realm_roller/custom_widgets/generator_pages/generator_page.dart';
import 'package:realm_roller/custom_widgets/route_builder/route_builder.dart';
import 'package:realm_roller/pages/names/names_view/names_view.dart';

import '../../../custom_widgets/dropdowns/dropdown.dart';

/// The page for generating settlement names
class SettlementNamesGenerationPage extends StatefulWidget {
  const SettlementNamesGenerationPage({super.key});

  @override
  State<SettlementNamesGenerationPage> createState() =>
      _SettlementNamesGenerationPageState();
}

class _SettlementNamesGenerationPageState
    extends State<SettlementNamesGenerationPage> {
  String currentSettlement = "Random";
  String currentRace = "Random";

  static const _numberOfNames = 10;

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

    final names =
        UniqueGenerator(settlementType.getNameGenerator(race), _numberOfNames)
            .generate();

    Navigator.of(context).push(buildRoute(
      NamesView(
        imagePath: getSettlementImage(settlementType),
        subtitle: titled(
            "${race?.getAdjective() ?? "mixed"} ${settlementType.getSettlementType()} names"),
        names: names,
      ),
    ));
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
          title: "Settlement Names Generator",
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