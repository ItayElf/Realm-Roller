import 'package:flutter/material.dart';
import 'package:realm_roller/assets_handlers/generators_data.dart';
import 'package:realm_roller/custom_widgets/generator_card/generator_card.dart';
import 'package:realm_roller/custom_widgets/route_builder/route_builder.dart';
import 'package:realm_roller/pages/general/generators_page/generators_page.dart';

class FavoriteGenerators extends StatelessWidget {
  const FavoriteGenerators({super.key});

  void onSettings(BuildContext context) {}
  void onAllGenerators(BuildContext context) =>
      Navigator.of(context).push(buildRoute(const GeneratorsPage()));

  @override
  Widget build(BuildContext context) {
    final favoriteGenerators = [
      "Names",
      "Npcs",
      "Locations",
      "Settlement Names"
    ];
    final favoriteGeneratorsData = getGeneratorsData(favoriteGenerators);

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          getTitleBar(context),
          const SizedBox(height: 12),
          getGeneratorCards(context, favoriteGeneratorsData),
          const SizedBox(height: 12),
          getAllGeneratorsButton(context)
        ],
      ),
    );
  }

  SizedBox getGeneratorCards(
      BuildContext context, List<GeneratorData> favoriteGeneratorsData) {
    return SizedBox(
      height: Theme.of(context).textTheme.titleMedium!.fontSize! + 26,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, i) =>
                GeneratorCard(generatorData: favoriteGeneratorsData[i]),
            separatorBuilder: (context, i) => const SizedBox(width: 20),
            itemCount: favoriteGeneratorsData.length,
          ),
        ),
      ),
    );
  }

  InkWell getAllGeneratorsButton(BuildContext context) {
    return InkWell(
      onTap: () => onAllGenerators(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "For all generators",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Icon(
            Icons.east,
            size: Theme.of(context).textTheme.titleLarge!.fontSize,
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
            "Favorite Generators:",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          InkWell(
            onTap: () => onSettings(context),
            child: Icon(
              Icons.settings,
              size: Theme.of(context).textTheme.headlineSmall!.fontSize,
            ),
          ),
        ],
      ),
    );
  }

  List<GeneratorData> getGeneratorsData(List<String> favoriteGenerators) {
    List<GeneratorData> favoriteGeneratorsData = [];

    for (final generatorName in favoriteGenerators) {
      if (!generatorsData.containsKey(generatorName)) {
        debugPrint("No generator named $generatorName");
      } else {
        favoriteGeneratorsData.add(generatorsData[generatorName]!);
      }
    }

    return favoriteGeneratorsData;
  }
}
