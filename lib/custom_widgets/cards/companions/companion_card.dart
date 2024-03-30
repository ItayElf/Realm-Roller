import 'package:flutter/material.dart';
import 'package:randpg/entities/companions.dart';
import 'package:randpg/string_manipulations.dart';
import 'package:realm_roller/assets_handlers/image_path_finders.dart';
import 'package:realm_roller/custom_widgets/cards/entity_card.dart';
import 'package:realm_roller/custom_widgets/route_builder/route_builder.dart';
import 'package:realm_roller/pages/companions/companion_view/companion_view.dart';

class CompanionCard extends EntityCard {
  CompanionCard({
    super.key,
    required super.size,
    required Companion companion,
  }) : super(
          title: titled(companion.name),
          subtitle:
              "${titled(companion.gender.name)} ${companion.companionType.getCompanionType()}",
          imagePath: getCompanionImage(companion.companionType),
          onClick: (BuildContext context) => Navigator.of(context)
              .push(buildRoute(CompanionView(companion: companion))),
        );
}
