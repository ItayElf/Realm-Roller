import 'package:flutter/material.dart';
import 'package:randpg/entities/settlements.dart';
import 'package:randpg/string_manipulations.dart';
import 'package:realm_roller/assets_handlers/image_path_finders.dart';
import 'package:realm_roller/custom_widgets/entity_pages/entity_page.dart';
import 'package:realm_roller/custom_widgets/expanded_paragraphs/expanded_paragraph.dart';
import 'package:realm_roller/custom_widgets/tiles/location/location_tile.dart';
import 'package:realm_roller/custom_widgets/tiles/npc/npc_tile.dart';

/// A widgets that features a settlement
class SettlementView extends StatelessWidget {
  const SettlementView({super.key, required this.settlement});

  final Settlement settlement;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: EntityPage(
          title: settlement.name,
          subtitle: subtitle,
          imagePath: getSettlementImage(settlement.settlementType),
          entity: settlement,
          children: [
            const SizedBox(height: 18),
            Text(
              settlement.description.replaceAll("\n", "\n\n"),
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 16),
            getPopulationText(context),
            const SizedBox(height: 16),
            getTroubleText(context),
            const SizedBox(height: 24),
            getLocationTiles(),
            const SizedBox(height: 24),
            getCharacterTiles(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  ExpandedParagraph getCharacterTiles() {
    return ExpandedParagraph(
      title: "Important Characters",
      icon: Icons.groups,
      child: Column(
        children: settlement.importantCharacters
            .map((npc) => Column(
                  children: [
                    NpcTile(npc: npc),
                    const SizedBox(height: 12),
                  ],
                ))
            .toList(),
      ),
    );
  }

  ExpandedParagraph getLocationTiles() {
    return ExpandedParagraph(
      title: "Locations",
      icon: Icons.location_on,
      child: Column(
        children: settlement.locations
            .map((location) => Column(
                  children: [
                    LocationTile(location: location),
                    const SizedBox(height: 12),
                  ],
                ))
            .toList(),
      ),
    );
  }

  Text getTroubleText(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: "Trouble: ",
        style: Theme.of(context).textTheme.titleLarge,
        children: [
          TextSpan(
            text: titled(settlement.trouble),
            style: Theme.of(context).textTheme.bodyLarge,
          )
        ],
      ),
    );
  }

  Text getPopulationText(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: "Population: ",
        style: Theme.of(context).textTheme.titleLarge,
        children: [
          TextSpan(
            text: "${settlement.population}",
            style: Theme.of(context).textTheme.bodyLarge,
          )
        ],
      ),
    );
  }

  String get subtitle => titled(
      "${settlement.dominantRace?.getAdjective() ?? "mixed"} ${settlement.dominantOccupation} ${settlement.settlementType.getSettlementType()}");
}
