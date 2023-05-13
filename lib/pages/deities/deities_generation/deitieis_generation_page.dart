import 'package:flutter/material.dart';
import 'package:randpg/entities/custom/custom_races.dart';
import 'package:randpg/entities/deities.dart';
import 'package:randpg/entities/races.dart';
import 'package:randpg/enums/alignment.dart';
import 'package:randpg/enums/gender.dart';
import 'package:randpg/generators.dart';
import 'package:randpg/string_manipulations.dart';
import 'package:realm_roller/assets_handlers/custom_icons.dart';
import 'package:realm_roller/custom_widgets/generator_pages/generator_page.dart';
import 'package:randpg/entities/npcs.dart' as Npcs;

import '../../../custom_widgets/dropdowns/dropdown.dart';

/// The page for generating names
class DeitiesGenerationPage extends StatefulWidget {
  const DeitiesGenerationPage({super.key});

  @override
  State<DeitiesGenerationPage> createState() => _DeitiesGenerationPageState();
}

class _DeitiesGenerationPageState extends State<DeitiesGenerationPage> {
  String currentDeity = "Random";
  String currentAlignment = "Random";
  List<String> alignmentPool = ["Random"];

  @override
  void initState() {
    super.initState();
    setState(() {
      alignmentPool = getAvailableAlignments(currentDeity);
    });
  }

  void onGenerate(BuildContext context) {
    final deityType = currentDeity == "Random"
        ? ListItemGenerator(DeityManager.activeDeityTypes).generate()
        : DeityManager.getDeityTypeByType(currentDeity.toLowerCase());

    final alignment = currentAlignment == "Random"
        ? BaseAlignmentGenerator().generate()
        : currentAlignment == "Unaligned"
            ? null
            : getCurrentAlignment();

    final deity = DeityGenerator(deityType, alignment).generate();

    print(deity);
  }

  Npcs.Alignment getCurrentAlignment() => Npcs.Alignment(
        ethical: EthicalAlignment.fromName(
          currentAlignment.split(" ").first.toLowerCase(),
        ),
        moral: MoralAlignment.fromName(
          currentAlignment.split(" ").last.toLowerCase(),
        ),
      );

  void onDeityChange(String? value) {
    setState(() {
      currentDeity = value ?? currentDeity;
      if (value == "Archangel") {
        currentAlignment = "Lawful Good";
      } else if (value == "Demon Lord") {
        currentAlignment = "Chaotic Evil";
      } else if (value == "Primordial") {
        currentAlignment = "Unaligned";
      }
      alignmentPool = getAvailableAlignments(currentDeity);
    });
  }

  void onAlignmentChange(String? value) {
    setState(() {
      currentAlignment = value ?? currentAlignment;
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
              title: "Deity:",
              icon: Icons.self_improvement,
              currentValue: currentDeity,
              onChanged: onDeityChange,
              options: [
                "Random",
                ...DeityManager.activeDeityTypes
                    .map((e) => titledEach(e.getDeityType()))
              ],
            ),
            const SizedBox(height: 28),
            Dropdown(
              title: "Alignment:",
              icon: CustomIcons.yin_yang,
              currentValue: currentAlignment,
              onChanged: onAlignmentChange,
              options: alignmentPool,
            ),
          ],
        ),
      ),
    );
  }

  List<String> getAvailableAlignments(String deity) {
    if (deity == "Archangel") {
      return ["Lawful Good"];
    } else if (deity == "Demon Lord") {
      return ["Chaotic Evil"];
    } else if (deity == "Primordial") {
      return ["Unaligned"];
    }

    final List<String> alignments = ["Random", "Unaligned"];
    for (final ethical in EthicalAlignment.values) {
      for (final moral in MoralAlignment.values) {
        alignments.add(titledEach("${ethical.name} ${moral.name}"));
      }
    }
    return alignments;
  }
}
