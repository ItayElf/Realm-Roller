import 'package:flutter/material.dart';
import 'package:realm_roller/custom_widgets/cards/card_factory.dart';

import '../../main_page/background/main_page_background.dart';

class SavedEntitiesPage extends StatelessWidget {
  const SavedEntitiesPage({
    super.key,
    required this.title,
    required this.entities,
  });

  final String title;
  final List entities;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final left = entities.where((entity) => entities.indexOf(entity) % 2 == 0);
    final right = entities.where((entity) => !left.contains(entity));

    final cardSize = (width - 60) / 2;

    return MainPageBackground(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "Saved $title",
            style: Theme.of(context)
                .textTheme
                .displayMedium!
                .copyWith(color: Colors.black),
          ),
        ),
        const SizedBox(height: 36),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(child: getEntitiesColumn(left, cardSize)),
                const SizedBox(width: 20),
                Flexible(child: getEntitiesColumn(right, cardSize))
              ],
            ),
          ),
        )
      ],
    );
    ;
  }

  Widget getEntitiesColumn(Iterable entities, double size) {
    if (entities.isEmpty) {
      return SizedBox(width: size);
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: entities
          .map(
            (e) => getCardFromEntity(e, size),
          )
          .toList(),
    );
  }
}
