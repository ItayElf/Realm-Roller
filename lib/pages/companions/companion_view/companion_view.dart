import 'package:flutter/material.dart';
import 'package:randpg/entities/companions.dart';
import 'package:randpg/string_manipulations.dart';
import 'package:realm_roller/assets_handlers/image_path_finders.dart';
import 'package:realm_roller/custom_widgets/entity_pages/entity_page.dart';
import 'package:realm_roller/custom_widgets/expanded_paragraphs/expanded_paragraph.dart';

/// A view for the companion entity
class CompanionView extends StatelessWidget {
  const CompanionView({super.key, required this.companion});

  final Companion companion;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: EntityPage(
          title: titled(companion.name),
          subtitle: subtitle,
          imagePath: getCompanionImage(companion.companionType),
          entity: companion,
          children: [
            const SizedBox(height: 18),
            Text(
              companion.appearance,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 18),
            Text(
              companion.personality,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 24),
            ExpandedParagraph(
              title: "Quirks",
              icon: Icons.auto_awesome,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: companion.quirks
                    .map((quirk) => getListText(quirk, context))
                    .toList(),
              ),
            ),
            ExpandedParagraph(
              title: "Skills",
              icon: Icons.construction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: companion.skills
                    .map((skill) => getListText(skill, context))
                    .toList(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Column getListText(String text, BuildContext context) {
    return Column(
      children: [
        Text(
          "\u2022\t${titled(text)}",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  String get subtitle =>
      "${titled(companion.gender.name)} ${companion.companionType.getCompanionType()}";
}
