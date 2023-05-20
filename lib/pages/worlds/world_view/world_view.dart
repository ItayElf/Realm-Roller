import 'package:flutter/material.dart';
import 'package:randpg/entities/worlds.dart';
import 'package:realm_roller/assets_handlers/image_path_finders.dart';
import 'package:realm_roller/custom_widgets/cards/deities/deity_card.dart';
import 'package:realm_roller/custom_widgets/entity_pages/entity_page.dart';
import 'package:realm_roller/custom_widgets/expanded_paragraphs/expanded_paragraph.dart';
import 'package:realm_roller/custom_widgets/tiles/deity/deity_tile.dart';
import 'package:realm_roller/custom_widgets/tiles/guild/guild_tile.dart';
import 'package:realm_roller/custom_widgets/tiles/kingdom/kingdom_tile.dart';
import 'package:realm_roller/custom_widgets/tiles/landscape/landscape_tile.dart';
import 'package:realm_roller/custom_widgets/tiles/npc/npc_tile.dart';
import 'package:realm_roller/pages/worlds/world_view/stereotypes/stereotype_panel.dart';
import 'package:realm_roller/pages/worlds/world_view/world_lore_view.dart';

class WorldView extends StatelessWidget {
  const WorldView({super.key, required this.world});

  final World world;

  @override
  Widget build(BuildContext context) {
    final cardSize = (MediaQuery.of(context).size.width - 20 * 4) / 3;

    return SafeArea(
      child: Material(
        child: EntityPage(
          title: world.name,
          subtitle: "",
          imagePath: getWorldImage(world),
          children: [
            const SizedBox(height: 18),
            WorldLoreView(
              worldLore: world.worldLore,
              worldName: world.name,
            ),
            const SizedBox(height: 24),
            ExpandedParagraph(
              title: "Stereotypes",
              icon: Icons.psychology_alt,
              child: StereotypePanel(stereotypes: world.opinions),
            ),
            ExpandedParagraph(
              title: "Deities",
              icon: Icons.self_improvement,
              child: GridView.count(
                shrinkWrap: true,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                children: world.deities
                    .map(
                      (e) => DeityCard(size: cardSize, deity: e),
                    )
                    .toList(),
              ),
            ),
            const SizedBox(height: 24),
            ExpandedParagraph(
              title: "Lesser Deities",
              icon: Icons.self_improvement,
              child: getList(
                (_, i) => DeityTile(deity: world.lesserDeities[i]),
                world.lesserDeities.length,
              ),
            ),
            const SizedBox(height: 24),
            ExpandedParagraph(
              title: "Higher Deities",
              icon: Icons.self_improvement,
              child: getList(
                (_, i) => DeityTile(deity: world.higherDeities[i]),
                world.higherDeities.length,
              ),
            ),
            const SizedBox(height: 24),
            ExpandedParagraph(
              title: "Kingdoms",
              icon: Icons.flag,
              child: getList(
                (_, i) => KingdomTile(kingdom: world.kingdoms[i]),
                world.kingdoms.length,
              ),
            ),
            const SizedBox(height: 24),
            ExpandedParagraph(
              title: "Worldwide Guilds",
              icon: Icons.diversity_3,
              child: getList(
                (_, i) => GuildTile(guild: world.guilds[i]),
                world.guilds.length,
              ),
            ),
            const SizedBox(height: 24),
            ExpandedParagraph(
              title: "Landscapes",
              icon: Icons.landscape,
              child: getList(
                (_, i) => LandscapeTile(landscape: world.landscapes[i]),
                world.landscapes.length,
              ),
            ),
            const SizedBox(height: 24),
            ExpandedParagraph(
              title: "Important Characters",
              icon: Icons.groups,
              child: getList(
                (_, i) => NpcTile(npc: world.importantPeople[i]),
                world.importantPeople.length,
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget getList(Widget? Function(BuildContext, int) builder, int count) =>
      ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: builder,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemCount: count,
      );
}
