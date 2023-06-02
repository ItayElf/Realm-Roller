import 'package:flutter/material.dart';
import 'package:randpg/entities/npcs.dart';
import 'package:randpg/string_manipulations.dart';
import 'package:realm_roller/assets_handlers/image_path_finders.dart';
import 'package:realm_roller/custom_widgets/cards/entity_card.dart';
import 'package:realm_roller/custom_widgets/route_builder/route_builder.dart';
import 'package:realm_roller/pages/npcs/npc_view/npc_view.dart';

class NpcCard extends EntityCard {
  NpcCard({
    super.key,
    required super.size,
    required Npc npc,
  }) : super(
          title: titled(npc.name),
          subtitle: titled(
            "${npc.gender.name} ${npc.race.getName()} ${npc.occupation}",
          ),
          imagePath: getRaceImage(npc.race),
          onClick: (BuildContext context) =>
              Navigator.of(context).push(buildRoute(NpcView(npc: npc))),
        );
}
