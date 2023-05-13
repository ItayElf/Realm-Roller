import 'package:flutter/material.dart';
import 'package:randpg/entities/npcs.dart';
import 'package:randpg/string_manipulations.dart';
import 'package:realm_roller/assets_handlers/image_path_finders.dart';
import 'package:realm_roller/custom_widgets/route_builder/route_builder.dart';
import 'package:realm_roller/custom_widgets/tiles/tile.dart';
import 'package:realm_roller/pages/npcs/npc_view/npc_view.dart';

class NpcTile extends Tile {
  NpcTile({super.key, required Npc npc})
      : super(
          title: npc.name,
          imagePath: getRaceImage(npc.race),
          subtitle: titled(
            "${npc.gender.name} ${npc.race.getName()} ${npc.occupation}",
          ),
          onClick: (BuildContext context) =>
              Navigator.of(context).push(buildRoute(NpcView(npc: npc))),
        );
}
