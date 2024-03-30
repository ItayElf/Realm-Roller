import 'package:flutter/material.dart';
import 'package:randpg/entities/companions.dart';
import 'package:randpg/enums/gender.dart';
import 'package:randpg/generators.dart';
import 'package:randpg/string_manipulations.dart';
import 'package:realm_roller/assets_handlers/custom_icons.dart';
import 'package:realm_roller/assets_handlers/image_path_finders.dart';
import 'package:realm_roller/custom_widgets/dropdowns/dropdown.dart';
import 'package:realm_roller/custom_widgets/generator_pages/generator_page.dart';
import 'package:realm_roller/custom_widgets/route_builder/route_builder.dart';
import 'package:realm_roller/extensions/entities/names_data.dart';
import 'package:realm_roller/pages/names/names_view/names_view.dart';

class CompanionNameGenerationPage extends StatefulWidget {
  const CompanionNameGenerationPage({super.key});

  @override
  State<CompanionNameGenerationPage> createState() =>
      _CompanionNameGenerationPageState();
}

class _CompanionNameGenerationPageState
    extends State<CompanionNameGenerationPage> {
  String currentCompanionType = "Random";
  String currentGender = "Random";

  static const _numberOfNames = 10;

  void onGenerate(BuildContext context) {
    final companionType = currentCompanionType == "Random"
        ? ListItemGenerator(const CompanionManager().activeTypes).generate()
        : const CompanionManager().getType(currentCompanionType.toLowerCase());

    final names = List.generate(
      _numberOfNames,
      (index) => titled(companionType.getNameGenerator(getGender()).generate()),
    );

    final gender = currentGender == "Random" ? null : getGender();

    final nameData = CompanionNamesData(
      names: names,
      imagePath: getCompanionImage(companionType),
      description: titled(
          "${gender?.name ?? "mixed"} ${companionType.getCompanionType()} names"),
    );

    Navigator.of(context).push(buildRoute(
      NamesView(
        namesData: nameData,
      ),
    ));
  }

  Gender getGender() => currentGender == "Random"
      ? ListItemGenerator(Gender.values).generate()
      : Gender.values.byName(currentGender.toLowerCase());

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
          title: "Companion Name Generator",
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
