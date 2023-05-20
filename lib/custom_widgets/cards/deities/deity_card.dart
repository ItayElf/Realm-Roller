import 'package:flutter/material.dart';
import 'package:randpg/entities/deities.dart';
import 'package:randpg/string_manipulations.dart';
import 'package:realm_roller/assets_handlers/image_path_finders.dart';
import 'package:realm_roller/custom_widgets/cards/entity_card.dart';
import 'package:realm_roller/custom_widgets/route_builder/route_builder.dart';
import 'package:realm_roller/pages/deities/deity_view/deity_view.dart';

class DeityCard extends EntityCard {
  DeityCard({
    super.key,
    required super.size,
    required Deity deity,
  }) : super(
          title: titled(deity.name),
          subtitle: getAlignment(deity),
          imagePath: getDeityImage(deity.deityType),
          onClick: (BuildContext context) =>
              Navigator.of(context).push(buildRoute(DeityView(deity: deity))),
        );

  static String getAlignment(Deity deity) => deity.alignment == null
      ? "Unaligned"
      : titled(
          "${deity.alignment!.ethical.name} ${deity.alignment!.moral.name}");
}
