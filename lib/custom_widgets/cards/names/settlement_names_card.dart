import 'package:flutter/material.dart';
import 'package:randpg/string_manipulations.dart';
import 'package:realm_roller/custom_widgets/cards/entity_card.dart';
import 'package:realm_roller/custom_widgets/route_builder/route_builder.dart';
import 'package:realm_roller/extensions/entities/names_data.dart';
import 'package:realm_roller/pages/names/names_view/names_view.dart';

class SettlementNamesCard extends EntityCard {
  SettlementNamesCard({
    super.key,
    required super.size,
    required SettlementNamesData namesData,
  }) : super(
          title: "Names",
          subtitle: titled(namesData.description),
          imagePath: namesData.imagePath,
          onClick: (BuildContext context) => Navigator.of(context)
              .push(buildRoute(NamesView(namesData: namesData))),
        );
}
