import 'package:flutter/material.dart';
import 'package:randpg/entities/companions.dart';
import 'package:randpg/enums/gender.dart';
import 'package:randpg/generators.dart';
import 'package:randpg/string_manipulations.dart';
import 'package:realm_roller/assets_handlers/custom_icons.dart';
import 'package:realm_roller/custom_widgets/dropdowns/dropdown.dart';
import 'package:realm_roller/custom_widgets/generator_pages/generator_page.dart';
import 'package:realm_roller/custom_widgets/route_builder/route_builder.dart';
import 'package:realm_roller/pages/companions/companion_view/companion_view.dart';

class CompanionGenerationPage extends StatefulWidget {
  const CompanionGenerationPage({super.key});

  @override
  State<CompanionGenerationPage> createState() =>
      _CompanionGenerationPageState();
}

class _CompanionGenerationPageState extends State<CompanionGenerationPage> {
  String currentCompanionType = "Random";
  String currentGender = "Random";

  void onGenerate(BuildContext context) {
    final companionType = currentCompanionType == "Random"
        ? ListItemGenerator(const CompanionManager().activeTypes).generate()
        : const CompanionManager().getType(currentCompanionType.toLowerCase());
    final gender = currentGender == "Random"
        ? ListItemGenerator(Gender.values).generate()
        : Gender.values.byName(currentGender.toLowerCase());

    final companion = CompanionGenerator(companionType, gender).generate();
    Navigator.of(context).push(buildRoute(CompanionView(companion: companion)));
  }

  void onCompanionChange(String? value) {
    setState(() {
      currentCompanionType = value ?? currentCompanionType;
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
          title: "Companion Generator",
          onGenerate: () => onGenerate(context),
          children: [
            Dropdown(
              title: "Companion:",
              icon: Icons.pets,
              currentValue: currentCompanionType,
              onChanged: onCompanionChange,
              options: [
                "Random",
                ...const CompanionManager()
                    .activeTypes
                    .map((e) => titledEach(e.getCompanionType()))
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
