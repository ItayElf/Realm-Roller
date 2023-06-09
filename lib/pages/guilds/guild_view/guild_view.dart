import 'package:flutter/material.dart';
import 'package:randpg/entities/guilds.dart';
import 'package:randpg/string_manipulations.dart';
import 'package:realm_roller/assets_handlers/image_path_finders.dart';
import 'package:realm_roller/custom_widgets/emblem_viewer/emblem_viewer.dart';
import 'package:realm_roller/custom_widgets/entity_pages/entity_page.dart';
import 'package:realm_roller/custom_widgets/expanded_paragraphs/expanded_paragraph.dart';
import 'package:realm_roller/custom_widgets/route_builder/route_builder.dart';
import 'package:realm_roller/custom_widgets/tiles/npc/npc_tile.dart';
import 'package:realm_roller/pages/emblem/emblem_view/emblem_view.dart';

/// A view that features a guild
class GuildView extends StatelessWidget {
  const GuildView({super.key, required this.guild});

  final Guild guild;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: SelectionArea(
          child: EntityPage(
            title: guild.name,
            subtitle: titled(guild.guildType.getGuildType()),
            imagePath: getGuildImage(guild.guildType),
            entity: guild,
            children: [
              const SizedBox(height: 18),
              Text(
                guild.history.replaceAll("\n", "\n\n"),
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 16),
              getKnownForText(context),
              const SizedBox(height: 24),
              getEmblemPreview(context),
              const SizedBox(height: 8),
              getMottoText(context),
              const SizedBox(height: 24),
              getSpecialties(context),
              const SizedBox(height: 24),
              getQuests(context),
              const SizedBox(height: 24),
              getLeader(),
              const SizedBox(height: 24),
              getNotableMembers(),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  InkWell getEmblemPreview(BuildContext context) {
    return InkWell(
      child: EmblemViewer(emblem: guild.emblem),
      onTap: () => Navigator.of(context).push(buildRoute(EmblemView(
        emblem: guild.emblem,
        fileName: guild.name,
      ))),
    );
  }

  ExpandedParagraph getLeader() {
    return ExpandedParagraph(
      title: "Leader",
      icon: Icons.person,
      child: NpcTile(
        npc: guild.leader,
      ),
    );
  }

  ExpandedParagraph getQuests(BuildContext context) {
    return ExpandedParagraph(
      title: "Quests",
      icon: Icons.quiz,
      child: Column(
        children:
            guild.quests.map((quest) => getListEntry(context, quest)).toList(),
      ),
    );
  }

  ExpandedParagraph getSpecialties(BuildContext context) {
    return ExpandedParagraph(
      title: "Specialties",
      icon: Icons.stars,
      child: Column(
        children: guild.specialties
            .map((specialty) => getListEntry(context, specialty))
            .toList(),
      ),
    );
  }

  SizedBox getMottoText(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Text(
        "\"${titled(guild.motto)}\"",
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(fontStyle: FontStyle.italic),
        textAlign: TextAlign.center,
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

  Text getKnownForText(BuildContext context) {
    return Text.rich(
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
}
