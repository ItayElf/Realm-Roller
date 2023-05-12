import 'package:flutter/material.dart';
import 'package:randpg/entities/races.dart';
import 'package:randpg/enums/gender.dart';
import 'package:randpg/generators.dart';
import 'package:randpg/string_manipulations.dart';
import 'package:realm_roller/assets_handlers/custom_icons.dart';
import 'package:realm_roller/custom_widgets/generator_pages/generator_page.dart';

import '../../../custom_widgets/dropdowns/dropdown.dart';

/// The page for generating names
class NamesGenerationPage extends StatefulWidget {
  const NamesGenerationPage({super.key});

  @override
  State<NamesGenerationPage> createState() => _NamesGenerationPageState();
}

class _NamesGenerationPageState extends State<NamesGenerationPage> {
  String currentRace = "Random";
  String currentGender = "Random";

  static const _numberOfNames = 10;

  void onGenerate() {
    final race = currentRace == "Random"
        ? ListItemGenerator(RaceManager.activeRaces).generate()
        : RaceManager.getRaceByName(currentRace.toLowerCase());

    final gender = currentGender == "Random"
        ? ListItemGenerator(Gender.values).generate()
        : Gender.values.byName(currentGender);

    final names = UniqueGenerator(
      race.getNameGenerator(gender),
      _numberOfNames,
    ).generate();

    print(names);
  }

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
          title: "Names Generator",
          onGenerate: onGenerate,
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
