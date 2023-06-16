import 'package:flutter/material.dart';
import 'package:randpg/entities/races.dart';
import 'package:randpg/entities/settlements.dart';
import 'package:randpg/generators.dart';
import 'package:randpg/string_manipulations.dart';
import 'package:realm_roller/assets_handlers/image_path_finders.dart';
import 'package:realm_roller/custom_widgets/generator_pages/generator_page.dart';
import 'package:realm_roller/custom_widgets/route_builder/route_builder.dart';
import 'package:realm_roller/extensions/entities/names_data.dart';
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
        ? ListItemGenerator(const SettlementManager().activeTypes).generate()
        : const SettlementManager().getType(currentSettlement.toLowerCase());

    final race = currentRace == "Random"
        ? ListItemGenerator([...const RaceManager().activeTypes, null])
            .generate()
        : currentRace == "None"
            ? null
            : const RaceManager().getType(currentRace.toLowerCase());

    final names =
        UniqueGenerator(settlementType.getNameGenerator(race), _numberOfNames)
            .generate();

    final nameData = SettlementNamesData(
      names: names,
      imagePath: getSettlementImage(settlementType),
      description: titled(
          "${race?.getAdjective() ?? "mixed"} ${settlementType.getSettlementType()} names"),
    );

    Navigator.of(context).push(buildRoute(
      NamesView(
        namesData: nameData,
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
