import 'package:flutter/material.dart';
import 'package:randpg/entities/settlements.dart';
import 'package:randpg/string_manipulations.dart';
import 'package:realm_roller/assets_handlers/image_path_finders.dart';
import 'package:realm_roller/custom_widgets/route_builder/route_builder.dart';
import 'package:realm_roller/custom_widgets/tiles/tile.dart';
import 'package:realm_roller/pages/settlements/settlement_view/settlement_view.dart';

class SettlementTile extends Tile {
  SettlementTile({super.key, required Settlement settlement})
      : super(
          title: settlement.name,
          imagePath: getSettlementImage(settlement.settlementType),
          subtitle: titled(
            "${settlement.dominantRace?.getAdjective() ?? "Mixed"} ${settlement.settlementType.getSettlementType()}",
          ),
          onClick: (BuildContext context) => Navigator.of(context)
              .push(buildRoute(SettlementView(settlement: settlement))),
        );
}
