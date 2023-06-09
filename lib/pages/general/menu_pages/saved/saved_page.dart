import 'package:flutter/material.dart';
import 'package:realm_roller/assets_handlers/entities_saver/entities_saver.dart';
import 'package:realm_roller/assets_handlers/entities_saver/saver_data.dart';
import 'package:realm_roller/assets_handlers/generators_data.dart';
import 'package:realm_roller/custom_widgets/generator_card/generator_card.dart';
import 'package:realm_roller/custom_widgets/main_menu/menu_paged.dart';
import 'package:realm_roller/pages/general/main_page/background/main_page_background.dart';
import 'package:realm_roller/pages/general/menu_pages/saved/saved_entities_page.dart';

class SavedPage extends StatelessWidget {
  const SavedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final types = entitiesToPaths.keys.toList();
    final titles = generatorsData.keys.toList();

    final entities = getAllEntities(types);

    final left = titles.where((title) => titles.indexOf(title) % 2 == 0);
    final right = titles.where((title) => !left.contains(title));

    return MainPageBackground(
      currentPage: MenuPage.saved,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "Saved",
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
                Flexible(child: getGeneratorsColumn(left, entities)),
                const SizedBox(width: 20),
                Flexible(child: getGeneratorsColumn(right, entities))
              ],
            ),
          ),
        )
      ],
    );
  }

  Map<String, List> getAllEntities(List<Type> types) {
    return {
      for (final type in types)
        entitiesToPaths[type]!: LocalStorage.getEntities(type)
    };
  }

  Column getGeneratorsColumn(
      Iterable<String> titles, Map<String, List> entities) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: titles
          .map(
            (e) => getGeneratorCard(e, entities),
          )
          .toList(),
    );
  }

  Column getGeneratorCard(String title, Map<String, List<dynamic>> entities) {
    final generatorData = generatorsData[title]!;

    return Column(
      children: [
        GeneratorCard(
          generatorData: GeneratorData(
            generatorPage: SavedEntitiesPage(
              entities: entities[title]!,
              title: title,
            ),
            title: generatorData.title,
            icon: generatorData.icon,
          ),
          shrink: false,
          disabled: entities[title]?.isEmpty ?? true,
        ),
        const SizedBox(height: 20)
      ],
    );
  }
}
