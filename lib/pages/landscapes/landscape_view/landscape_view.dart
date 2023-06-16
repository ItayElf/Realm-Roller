import 'package:flutter/material.dart';
import 'package:randpg/entities/landscapes.dart';
import 'package:randpg/string_manipulations.dart';
import 'package:realm_roller/assets_handlers/custom_icons.dart';
import 'package:realm_roller/assets_handlers/image_path_finders.dart';
import 'package:realm_roller/custom_widgets/entity_pages/entity_page.dart';
import 'package:realm_roller/custom_widgets/expanded_paragraphs/expanded_paragraph.dart';

/// A widget that features a landscape
class LandscapeView extends StatelessWidget {
  const LandscapeView({super.key, required this.landscape});

  final Landscape landscape;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: EntityPage(
          title: titledEach(landscape.name),
          subtitle: titled(landscape.landscapeType.getLandscapeType()),
          imagePath: getLandscapeImage(landscape.landscapeType),
          entity: landscape,
          children: [
            const SizedBox(height: 18),
            Text(
              description,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 24),
            ExpandedParagraph(
              title: "Special Features",
              icon: Icons.stars,
              child: Column(
                children: landscape.features
                    .map((feature) => getListEntry(context, feature))
                    .toList(),
              ),
            ),
            ExpandedParagraph(
              title: "Encounters",
              icon: CustomIcons.swords,
              child: Column(
                children: landscape.encounters
                    .map((encounter) => getListEntry(context, encounter))
                    .toList(),
              ),
            ),
            ExpandedParagraph(
              title: "Resources",
              icon: Icons.category,
              child: Column(
                children: landscape.resources
                    .map((resource) => getListEntry(context, resource))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column getListEntry(BuildContext context, String item) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "\u2022\t",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Flexible(
              child: Text(
                titled(item),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  String get description =>
      "${titledEach(landscape.name)} ${landscape.size}. It is known for ${landscape.knownFor}.\n\n"
      "Found ${landscape.location}, ${titledEach(landscape.name)} ${landscape.weather} and is ${landscape.travelRate} "
      "traveled through.";
}
