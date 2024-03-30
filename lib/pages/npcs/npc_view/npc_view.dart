import 'package:flutter/material.dart';
import 'package:randpg/entities/npcs.dart';
import 'package:randpg/string_manipulations.dart';
import 'package:realm_roller/custom_widgets/entity_pages/entity_page.dart';
import 'package:realm_roller/custom_widgets/expanded_paragraphs/expanded_paragraph.dart';
import 'package:realm_roller/custom_widgets/tiles/companion/companion_tile.dart';

import '../../../assets_handlers/image_path_finders.dart';
import 'npc_description_formatters.dart';

/// A page that shows an npc entity
class NpcView extends StatelessWidget {
  const NpcView({super.key, required this.npc});

  final Npc npc;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: EntityPage(
          title: titledEach(npc.name),
          subtitle: titled(subtitle),
          imagePath: getRaceImage(npc.race),
          entity: npc,
          children: [
            const SizedBox(height: 18),
            Text(
              getNpcDescription(npc),
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 24),
            ExpandedParagraph(
              title: "Special Traits",
              icon: Icons.stars,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: npc.physicalDescription.specialFeatures
                    .map((e) => Text(
                          "\u2022 ${titled(e)}\n",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ))
                    .toList(),
              ),
            ),
            ExpandedParagraph(
              title: "Personality",
              icon: Icons.psychology_alt,
              child: Text(
                getNpcPersonality(npc),
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.justify,
              ),
            ),
            const SizedBox(height: 24),
            if (npc.companions.isNotEmpty)
              ExpandedParagraph(
                title: "Companion${npc.companions.length == 1 ? "" : "s"}",
                icon: Icons.pets,
                child: Column(
                  children: npc.companions
                      .map(
                        (e) => Column(
                          children: [
                            CompanionTile(companion: e),
                            const SizedBox(height: 16),
                          ],
                        ),
                      )
                      .toList(),
                ),
              ),
            if (npc.companions.isNotEmpty) const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  String get subtitle =>
      "${npc.gender.name} ${npc.race.getName()} ${npc.occupation}";
}
