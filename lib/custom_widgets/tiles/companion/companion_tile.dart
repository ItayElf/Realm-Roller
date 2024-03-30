import 'package:flutter/material.dart';
import 'package:randpg/entities/companions.dart';
import 'package:randpg/string_manipulations.dart';
import 'package:realm_roller/assets_handlers/image_path_finders.dart';
import 'package:realm_roller/custom_widgets/route_builder/route_builder.dart';
import 'package:realm_roller/custom_widgets/tiles/tile.dart';
import 'package:realm_roller/pages/companions/companion_view/companion_view.dart';

class CompanionTile extends Tile {
  CompanionTile({super.key, required Companion companion})
      : super(
          title: companion.name,
          imagePath: getCompanionImage(companion.companionType),
          subtitle:
              "${titled(companion.gender.name)} ${companion.companionType.getCompanionType()}",
          onClick: (BuildContext context) => Navigator.of(context)
              .push(buildRoute(CompanionView(companion: companion))),
        );
}
