import 'package:flutter/material.dart';
import 'package:randpg/entities/races.dart';
import 'package:randpg/enums/gender.dart';
import 'package:randpg/generators.dart';
import 'package:randpg/string_manipulations.dart';
import 'package:realm_roller/assets_handlers/custom_icons.dart';
import 'package:realm_roller/assets_handlers/image_path_finders.dart';
import 'package:realm_roller/custom_widgets/generator_pages/generator_page.dart';
import 'package:realm_roller/custom_widgets/route_builder/route_builder.dart';
import 'package:realm_roller/pages/names/names_view/names_view.dart';

import '../../../custom_widgets/dropdowns/dropdown.dart';

/// The page for generating names
class NpcNamesGenerationPage extends StatefulWidget {
  const NpcNamesGenerationPage({super.key});

  @override
  State<NpcNamesGenerationPage> createState() => _NpcNamesGenerationPageState();
}

class _NpcNamesGenerationPageState extends State<NpcNamesGenerationPage> {
  String currentRace = "Random";
  String currentGender = "Random";

  static const _numberOfNames = 10;

  void onGenerate(BuildContext context) {
    final race = currentRace == "Random"
        ? ListItemGenerator(RaceManager.activeRaces).generate()
        : RaceManager.getRaceByName(currentRace.toLowerCase());

    final names = List.generate(
      _numberOfNames,
      (index) => race.getNameGenerator(getGender()).generate(),
    );

    final gender = currentGender == "Random" ? null : getGender();

    Navigator.of(context).push(buildRoute(
      NamesView(
        imagePath: getRaceImage(race),
        subtitle:
            titled("${gender?.name ?? "mixed"} ${race.getAdjective()} names"),
        names: names,
      ),
    ));
  }

  Gender getGender() => currentGender == "Random"
      ? ListItemGenerator(Gender.values).generate()
      : Gender.values.byName(currentGender);

  void onRaceChange(String? value) {
    setState(() {
      currentRace = value ?? currentRace;
    });
  }

  void onGenderChange(String? value) {
    setState(() {
      currentGender = value ?? currentGender;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: GeneratorPage(
          title: "Npc Name Generator",
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
            const SizedBox(height: 28),
            Dropdown(
              title: "Gender:",
              icon: CustomIcons.gender,
              currentValue: currentGender,
              onChanged: onGenderChange,
              options: [
                "Random",
                ...Gender.values.map((e) => titledEach(e.name))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
