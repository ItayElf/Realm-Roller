import 'package:flutter/material.dart';
import 'package:randpg/entities/guilds.dart';
import 'package:randpg/string_manipulations.dart';
import 'package:realm_roller/assets_handlers/image_path_finders.dart';
import 'package:realm_roller/custom_widgets/emblem_painter/emblem_viewer.dart';
import 'package:realm_roller/custom_widgets/entity_pages/entity_page.dart';
import 'package:realm_roller/custom_widgets/expanded_paragraphs/expanded_paragraph.dart';
import 'package:realm_roller/custom_widgets/tiles/npc/npc_tile.dart';

/// A view that features a guild
class GuildView extends StatelessWidget {
  const GuildView({super.key, required this.guild});

  final Guild guild;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: EntityPage(
          title: guild.name,
          subtitle: titled(guild.guildType.getGuildType()),
          imagePath: getGuildImage(guild.guildType),
          children: [
            const SizedBox(height: 18),
            SelectableText(
              guild.history.replaceAll("\n", "\n\n"),
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 16),
            getKnownForText(context),
            const SizedBox(height: 24),
            EmblemViewer(
              emblem: guild.emblem,
              fileName: guild.name,
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: SelectableText(
                "\"${titled(guild.motto)}\"",
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 24),
            ExpandedParagraph(
              title: "Specialties",
              icon: Icons.stars,
              child: Column(
                children: guild.specialties
                    .map((specialty) => getListEntry(context, specialty))
                    .toList(),
              ),
            ),
            const SizedBox(height: 24),
            ExpandedParagraph(
              title: "Quests",
              icon: Icons.quiz,
              child: Column(
                children: guild.quests
                    .map((quest) => getListEntry(context, quest))
                    .toList(),
              ),
            ),
            const SizedBox(height: 24),
            ExpandedParagraph(
              title: "Leader",
              icon: Icons.person,
              child: NpcTile(
                npc: guild.leader,
              ),
            ),
            const SizedBox(height: 24),
            getNotableMembers(),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  ExpandedParagraph getNotableMembers() {
    return ExpandedParagraph(
      title: "Notable Members",
      icon: Icons.groups,
      child: Column(
        children: guild.notableMembers
            .map((member) => Column(
                  children: [
                    NpcTile(npc: member),
                    const SizedBox(height: 12),
                  ],
                ))
            .toList(),
      ),
    );
  }

  SelectableText getKnownForText(BuildContext context) {
    return SelectableText.rich(
      TextSpan(
        text: "Known For: ",
        style: Theme.of(context).textTheme.titleMedium,
        children: [
          TextSpan(
            text: guild.reputation,
            style: Theme.of(context).textTheme.bodyLarge,
          )
        ],
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
              child: SelectableText(
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
}
