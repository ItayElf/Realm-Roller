import 'package:flutter/material.dart';
import 'package:randpg/entities/worlds.dart';
import 'package:randpg/string_manipulations.dart';
import 'package:realm_roller/assets_handlers/image_path_finders.dart';
import 'package:realm_roller/custom_widgets/cards/entity_card.dart';
import 'package:realm_roller/custom_widgets/route_builder/route_builder.dart';
import 'package:realm_roller/pages/worlds/world_view/world_view.dart';

class WorldCard extends EntityCard {
  WorldCard({
    super.key,
    required super.size,
    required World world,
  }) : super(
          title: titled(world.name),
          subtitle: "World",
          imagePath: getWorldImage(world),
          onClick: (BuildContext context) =>
              Navigator.of(context).push(buildRoute(WorldView(world: world))),
        );
}
