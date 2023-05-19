import 'package:flutter/material.dart';
import 'package:randpg/entities/guilds.dart';
import 'package:randpg/string_manipulations.dart';
import 'package:realm_roller/assets_handlers/image_path_finders.dart';
import 'package:realm_roller/custom_widgets/route_builder/route_builder.dart';
import 'package:realm_roller/custom_widgets/tiles/tile.dart';
import 'package:realm_roller/pages/guilds/guild_view/guild_view.dart';

class GuildTile extends Tile {
  GuildTile({super.key, required Guild guild})
      : super(
          title: guild.name,
          imagePath: getGuildImage(guild.guildType),
          subtitle: titled(
            guild.guildType.getGuildType(),
          ),
          onClick: (BuildContext context) =>
              Navigator.of(context).push(buildRoute(GuildView(guild: guild))),
        );
}
