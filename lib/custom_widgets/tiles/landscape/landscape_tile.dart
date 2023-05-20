import 'package:flutter/material.dart';
import 'package:randpg/entities/landscapes.dart';
import 'package:randpg/string_manipulations.dart';
import 'package:realm_roller/assets_handlers/image_path_finders.dart';
import 'package:realm_roller/custom_widgets/route_builder/route_builder.dart';
import 'package:realm_roller/custom_widgets/tiles/tile.dart';
import 'package:realm_roller/pages/landscapes/landscape_view/landscape_view.dart';

class LandscapeTile extends Tile {
  LandscapeTile({super.key, required Landscape landscape})
      : super(
          title: landscape.name,
          imagePath: getLandscapeImage(landscape.landscapeType),
          subtitle: titled(
            landscape.landscapeType.getLandscapeType(),
          ),
          onClick: (BuildContext context) => Navigator.of(context)
              .push(buildRoute(LandscapeView(landscape: landscape))),
        );
}
