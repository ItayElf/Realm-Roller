import 'package:flutter/material.dart';
import 'package:realm_roller/custom_widgets/cards/card_factory.dart';

import 'random_entities_generation.dart';

class FeaturedEntities extends StatefulWidget {
  const FeaturedEntities({super.key});

  @override
  State<FeaturedEntities> createState() => _FeaturedEntitiesState();
}

class _FeaturedEntitiesState extends State<FeaturedEntities> {
  late List entities;

  static const randomEntitiesCount = 5;
  static const cardSize = 150.0;

  void onGenerate() {
    setState(() {
      entities = getRandomEntities(randomEntitiesCount);
    });
  }

  @override
  void initState() {
    super.initState();
    entities = getRandomEntities(randomEntitiesCount);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          getTitleBar(context),
          const SizedBox(height: 12),
          SizedBox(
            height: cardSize,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, i) => i < entities.length
                      ? getCardFromEntity(entities[i], cardSize)
                      : Container(),
                  separatorBuilder: (context, i) => const SizedBox(width: 16),
                  itemCount: entities.length + 1,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Padding getTitleBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Featured Entities:",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          InkWell(
            onTap: onGenerate,
            child: Icon(
              Icons.casino,
              size: Theme.of(context).textTheme.headlineSmall!.fontSize,
            ),
          ),
        ],
      ),
    );
  }
}
