import 'package:flutter/material.dart';
import 'package:randpg/entities/kingdoms.dart';
import 'package:randpg/string_manipulations.dart';
import 'package:realm_roller/assets_handlers/image_path_finders.dart';
import 'package:realm_roller/custom_widgets/route_builder/route_builder.dart';
import 'package:realm_roller/custom_widgets/tiles/tile.dart';
import 'package:realm_roller/pages/kingdoms/kingdom_view/kingdom_view.dart';

class KingdomTile extends Tile {
  KingdomTile({super.key, required Kingdom kingdom})
      : super(
          title: kingdom.name,
          imagePath: getKingdomImage(kingdom.governmentType),
          subtitle: titled(
            "${kingdom.race.getAdjective()} ${kingdom.governmentType.getGovernmentType()}",
          ),
          onClick: (BuildContext context) => Navigator.of(context)
              .push(buildRoute(KingdomView(kingdom: kingdom))),
        );
}
