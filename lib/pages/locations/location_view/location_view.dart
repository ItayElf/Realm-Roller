import 'package:flutter/material.dart';
import 'package:randpg/entities/settlements.dart';
import 'package:randpg/string_manipulations.dart';
import 'package:realm_roller/assets_handlers/image_path_finders.dart';
import 'package:realm_roller/custom_widgets/entity_pages/entity_page.dart';
import 'package:realm_roller/custom_widgets/expanded_paragraphs/expanded_paragraph.dart';
import 'package:realm_roller/custom_widgets/tiles/npc/npc_tile.dart';
import 'package:realm_roller/pages/locations/location_view/locations_goods_card.dart';

/// A widget for viewing a location
class LocationView extends StatelessWidget {
  const LocationView({
    super.key,
    required this.location,
  });

  final Location location;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Material(
      child: EntityPage(
        title: location.name,
        subtitle: titled(location.type.getLocationType()),
        imagePath: getLocationImage(location.type),
        children: [
          const SizedBox(height: 18),
          SelectableText(
            location.buildingDescription.replaceAll("\n", "\n\n"),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 24),
          ExpandedParagraph(
            title: "Location",
            icon: Icons.location_on,
            child: SelectableText(
              "${location.name} is located in ${location.zone}. It ${location.outsideDescription.join(" and ")}.",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          const SizedBox(height: 24),
          ExpandedParagraph(
            title: "Owner",
            icon: Icons.person,
            child: NpcTile(npc: location.owner),
          ),
          const SizedBox(height: 24),
          if (location.goods != null && location.goods!.isNotEmpty) ...[
            getLocationGoods(),
            const SizedBox(height: 24),
          ],
        ],
      ),
    ));
  }

  ExpandedParagraph getLocationGoods() {
    return ExpandedParagraph(
      title: "Goods",
      icon: Icons.shopping_basket,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: location.goods!
              .map((e) => Column(children: [
                    LocationGoodsCard(goods: e),
                    const SizedBox(height: 16),
                  ]))
              .toList(),
        ),
      ),
    );
  }
}
