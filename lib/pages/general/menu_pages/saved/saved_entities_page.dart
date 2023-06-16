import 'package:flutter/material.dart';
import 'package:realm_roller/assets_handlers/local_storage/local_storage.dart';
import 'package:realm_roller/assets_handlers/route_observer.dart';
import 'package:realm_roller/custom_widgets/cards/card_factory.dart';

import '../../main_page/background/main_page_background.dart';

class SavedEntitiesPage extends StatefulWidget {
  const SavedEntitiesPage({
    super.key,
    required this.title,
    required this.entityType,
  });

  final String title;
  final Type entityType;

  @override
  State<SavedEntitiesPage> createState() => _SavedEntitiesPageState();
}

class _SavedEntitiesPageState extends State<SavedEntitiesPage> with RouteAware {
  late List entities;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      routeObserver.subscribe(this, ModalRoute.of(context)!);
    });
    entities = LocalStorage.getEntities(widget.entityType);
  }

  @override
  void didPopNext() {
    super.didPopNext();
    setState(() {
      entities = LocalStorage.getEntities(widget.entityType);
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final left = entities.where((entity) => entities.indexOf(entity) % 2 == 0);
    final right = entities.where((entity) => !left.contains(entity));

    final cardSize = (width - 60) / 2;

    return MainPageBackground(
      children: [
        SizedBox(
          width: width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "Saved ${widget.title}",
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(color: Colors.black),
              ),
            ),
          ),
        ),
        const SizedBox(height: 36),
        SizedBox(
          width: width,
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
  }

  Widget getEntitiesColumn(Iterable entities, double size) {
    if (entities.isEmpty) {
      return SizedBox(width: size);
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: entities
          .map((e) => Column(
                children: [
                  getCardFromEntity(e, size),
                  const SizedBox(height: 20),
                ],
              ))
          .toList(),
    );
  }
}
