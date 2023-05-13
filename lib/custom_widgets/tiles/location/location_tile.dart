import 'package:flutter/material.dart';
import 'package:randpg/entities/settlements.dart';
import 'package:randpg/string_manipulations.dart';
import 'package:realm_roller/assets_handlers/image_path_finders.dart';
import 'package:realm_roller/custom_widgets/route_builder/route_builder.dart';
import 'package:realm_roller/custom_widgets/tiles/tile.dart';
import 'package:realm_roller/pages/locations/location_view/location_view.dart';

class LocationTile extends Tile {
  LocationTile({super.key, required Location location})
      : super(
          title: location.name,
          imagePath: getLocationImage(location.type),
          subtitle: titled(location.type.getLocationType()),
          onClick: (BuildContext context) =>
              Navigator.of(context).push(buildRoute(
            LocationView(location: location),
          )),
        );
}
