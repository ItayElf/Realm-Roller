import 'package:flutter/material.dart';
import 'package:randpg/entities/settlements.dart';
import 'package:randpg/string_manipulations.dart';
import 'package:realm_roller/assets_handlers/image_path_finders.dart';
import 'package:realm_roller/custom_widgets/cards/entity_card.dart';
import 'package:realm_roller/custom_widgets/route_builder/route_builder.dart';
import 'package:realm_roller/pages/locations/location_view/location_view.dart';

class LocationCard extends EntityCard {
  LocationCard({
    super.key,
    required super.size,
    required Location location,
  }) : super(
          title: titled(location.name),
          imagePath: getLocationImage(location.type),
          subtitle: titled(location.type.getLocationType()),
          onClick: (BuildContext context) =>
              Navigator.of(context).push(buildRoute(
            LocationView(location: location),
          )),
        );
}
