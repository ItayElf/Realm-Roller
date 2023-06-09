import 'package:flutter/material.dart';
import 'package:randpg/entities/landscapes.dart';
import 'package:randpg/generators.dart';
import 'package:randpg/string_manipulations.dart';
import 'package:realm_roller/custom_widgets/dropdowns/dropdown.dart';
import 'package:realm_roller/custom_widgets/generator_pages/generator_page.dart';
import 'package:realm_roller/custom_widgets/route_builder/route_builder.dart';
import 'package:realm_roller/pages/landscapes/landscape_view/landscape_view.dart';

/// A page used to generate landscapes
class LandscapeGenerationPage extends StatefulWidget {
  const LandscapeGenerationPage({super.key});

  @override
  State<LandscapeGenerationPage> createState() =>
      _LandscapeGenerationPageState();
}

class _LandscapeGenerationPageState extends State<LandscapeGenerationPage> {
  String currentLandscape = "Random";

  void onLandscapeChange(String? value) {
    setState(() {
      currentLandscape = value ?? currentLandscape;
    });
  }

  void onGenerate(BuildContext context) {
    final landscapeType = currentLandscape == "Random"
        ? ListItemGenerator(const LandscapeManager().activeTypes).generate()
        : const LandscapeManager().getType(currentLandscape.toLowerCase());

    final landscape = LandscapeGenerator(landscapeType).generate();

    Navigator.of(context).push(buildRoute(LandscapeView(landscape: landscape)));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: GeneratorPage(
          title: "Landscape Generator",
          onGenerate: () => onGenerate(context),
          children: [
            Dropdown(
              title: "Landscape:",
              icon: Icons.landscape,
              currentValue: currentLandscape,
              onChanged: onLandscapeChange,
              options: [
                "Random",
                ...const LandscapeManager()
                    .activeTypes
                    .map((e) => titledEach(e.getLandscapeType()))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
