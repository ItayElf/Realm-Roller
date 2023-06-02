import 'package:flutter/material.dart';
import 'package:randpg/entities/emblems.dart';
import 'package:realm_roller/custom_widgets/cards/entity_card.dart';
import 'package:realm_roller/custom_widgets/emblem_viewer/emblem_viewer.dart';
import 'package:realm_roller/custom_widgets/route_builder/route_builder.dart';
import 'package:realm_roller/pages/emblem/emblem_view/emblem_view.dart';

class EmblemCard extends EntityCard {
  EmblemCard({
    super.key,
    required super.size,
    required Emblem emblem,
  }) : super(
          title: "Emblem",
          subtitle: "${emblem.icons.length} icons",
          alternativeBackground: EmblemViewer(emblem: emblem),
          onClick: (BuildContext context) => Navigator.of(context)
              .push(buildRoute(EmblemView(emblem: emblem))),
        );
}
