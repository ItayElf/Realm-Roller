import 'package:flutter/material.dart';
import 'package:randpg/entities/guilds.dart';
import 'package:randpg/generators.dart';
import 'package:randpg/string_manipulations.dart';
import 'package:realm_roller/custom_widgets/dropdowns/dropdown.dart';
import 'package:realm_roller/custom_widgets/generator_pages/generator_page.dart';
import 'package:realm_roller/custom_widgets/route_builder/route_builder.dart';
import 'package:realm_roller/pages/guilds/guild_view/guild_view.dart';

/// A page used to generate landscapes
class GuildGenerationPage extends StatefulWidget {
  const GuildGenerationPage({super.key});

  @override
  State<GuildGenerationPage> createState() => _GuildGenerationPageState();
}

class _GuildGenerationPageState extends State<GuildGenerationPage> {
  String currentGuild = "Random";

  void onGuildChange(String? value) {
    setState(() {
      currentGuild = value ?? currentGuild;
    });
  }

  void onGenerate(BuildContext context) {
    final guildType = currentGuild == "Random"
        ? ListItemGenerator(const GuildManager().activeTypes).generate()
        : const GuildManager().getType(currentGuild.toLowerCase());

    final guild = GuildGenerator(guildType).generate();

    Navigator.of(context).push(buildRoute(GuildView(guild: guild)));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: GeneratorPage(
          title: "Guild Generator",
          onGenerate: () => onGenerate(context),
          children: [
            Dropdown(
              title: "Guild:",
              icon: Icons.diversity_3,
              currentValue: currentGuild,
              onChanged: onGuildChange,
              options: [
                "Random",
                ...const GuildManager()
                    .activeTypes
                    .map((e) => titledEach(e.getGuildType()))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
