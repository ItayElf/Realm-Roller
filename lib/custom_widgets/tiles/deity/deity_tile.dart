import 'package:flutter/material.dart';
import 'package:randpg/entities/deities.dart';
import 'package:randpg/string_manipulations.dart';
import 'package:realm_roller/assets_handlers/image_path_finders.dart';
import 'package:realm_roller/custom_widgets/route_builder/route_builder.dart';
import 'package:realm_roller/custom_widgets/tiles/tile.dart';
import 'package:realm_roller/pages/deities/deity_view/deity_view.dart';

class DeityTile extends Tile {
  DeityTile({super.key, required Deity deity})
      : super(
          title: deity.name,
          imagePath: getDeityImage(deity.deityType),
          subtitle: titled(
            "${deity.deityType.getDeityTitle(deity.gender)} of ${deity.domains.join(" and ")}",
          ),
          onClick: (BuildContext context) =>
              Navigator.of(context).push(buildRoute(DeityView(deity: deity))),
        );
}
