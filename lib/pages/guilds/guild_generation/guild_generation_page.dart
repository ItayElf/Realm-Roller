import 'package:flutter/material.dart';
import 'package:randpg/entities/guilds.dart';
import 'package:randpg/entities/landscapes.dart';
import 'package:randpg/generators.dart';
import 'package:randpg/string_manipulations.dart';
import 'package:realm_roller/custom_widgets/dropdowns/dropdown.dart';
import 'package:realm_roller/custom_widgets/generator_pages/generator_page.dart';
import 'package:realm_roller/custom_widgets/route_builder/route_builder.dart';
import 'package:realm_roller/pages/landscapes/landscape_view/landscape_view.dart';

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
        ? ListItemGenerator(GuildManager.activeGuildTypes).generate()
        : GuildManager.getGuildTypeByType(currentGuild.toLowerCase());

    final guild = GuildGenerator(guildType).generate();

    print(guild);
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
                ...GuildManager.activeGuildTypes
                    .map((e) => titledEach(e.getGuildType()))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
