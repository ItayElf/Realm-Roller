import 'package:flutter/material.dart';
import 'package:randpg/entities/kingdoms.dart';
import 'package:randpg/string_manipulations.dart';
import 'package:realm_roller/assets_handlers/custom_icons.dart';
import 'package:realm_roller/assets_handlers/image_path_finders.dart';
import 'package:realm_roller/custom_widgets/emblem_viewer/emblem_viewer.dart';
import 'package:realm_roller/custom_widgets/entity_pages/entity_page.dart';
import 'package:realm_roller/custom_widgets/expanded_paragraphs/expanded_paragraph.dart';
import 'package:realm_roller/custom_widgets/route_builder/route_builder.dart';
import 'package:realm_roller/custom_widgets/tiles/guild/guild_tile.dart';
import 'package:realm_roller/custom_widgets/tiles/npc/npc_tile.dart';
import 'package:realm_roller/custom_widgets/tiles/settlement/settlement_tile.dart';
import 'package:realm_roller/pages/emblem/emblem_view/emblem_view.dart';

class KingdomView extends StatelessWidget {
  const KingdomView({super.key, required this.kingdom});

  final Kingdom kingdom;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: EntityPage(
          title: kingdom.name,
          subtitle: subtitle,
          imagePath: getKingdomImage(kingdom.governmentType),
          entity: kingdom,
          children: [
            const SizedBox(height: 18),
            Text(
              kingdom.history.replaceAll("\n", "\n\n"),
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 16),
            getSubtitledText(
              context,
              "Population: ",
              separateThousands(kingdom.population),
            ),
            const SizedBox(height: 12),
            getSubtitledText(
              context,
              "Known for: ",
              kingdom.knownFor,
            ),
            const SizedBox(height: 12),
            getSubtitledText(
              context,
              "Trouble: ",
              kingdom.trouble,
            ),
            const SizedBox(height: 4),
            getEmblemPreview(context),
            getCaptionText(context),
            const SizedBox(height: 24),
            ExpandedParagraph(
              title: "Capital",
              icon: CustomIcons.capital,
              child: SettlementTile(settlement: kingdom.capital),
            ),
            const SizedBox(height: 24),
            ExpandedParagraph(
              title: kingdom.rulers.length == 1 ? "Ruler" : "Rulers",
              icon: CustomIcons.crown,
              child: getTileList(
                (i) => NpcTile(npc: kingdom.rulers[i]),
                kingdom.rulers.length,
              ),
            ),
            const SizedBox(height: 24),
            ExpandedParagraph(
              title: "Guilds",
              icon: Icons.diversity_3,
              child: getTileList(
                (i) => GuildTile(guild: kingdom.guilds[i]),
                kingdom.guilds.length,
              ),
            ),
            const SizedBox(height: 24),
            ExpandedParagraph(
              title: "Notable Settlements",
              icon: Icons.location_city,
              child: getTileList(
                (i) =>
                    SettlementTile(settlement: kingdom.importantSettlements[i]),
                kingdom.importantSettlements.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  InkWell getEmblemPreview(BuildContext context) {
    return InkWell(
      child: EmblemViewer(emblem: kingdom.emblem),
      onTap: () => Navigator.of(context).push(buildRoute(EmblemView(
        emblem: kingdom.emblem,
        fileName: kingdom.name,
      ))),
    );
  }

  Widget getTileList(Widget Function(int) builder, int items) => Column(
        children: [
          for (int i = 0; i < items; i++) ...[
            builder(i),
            const SizedBox(height: 12),
          ]
        ],
      );

  Text getSubtitledText(BuildContext context, String subtitle, String content) {
    return Text.rich(
      TextSpan(
        text: subtitle,
        style: Theme.of(context).textTheme.titleMedium,
        children: [
          TextSpan(
            text: content,
            style: Theme.of(context).textTheme.bodyLarge,
          )
        ],
      ),
    );
  }

  SizedBox getCaptionText(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Text(
        "The $kingdomTitle of ${kingdom.name}",
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(fontStyle: FontStyle.italic),
        textAlign: TextAlign.center,
      ),
    );
  }

  String get kingdomTitle =>
      kingdom.governmentType is Theocracy || kingdom.governmentType is Monarchy
          ? "kingdom"
          : kingdom.governmentType.getGovernmentType();

  String separateThousands(int number) => number.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => "${m[1]},");

  String get subtitle => titled(
      "${kingdom.race.getAdjective()} ${kingdom.governmentType.getGovernmentType()}");
}
