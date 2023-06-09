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

    final left = types.where((type) => types.indexOf(type) % 2 == 0);
    final right = types.where((type) => !left.contains(type));

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
                Flexible(child: getGeneratorsColumn(left)),
                const SizedBox(width: 20),
                Flexible(child: getGeneratorsColumn(right))
              ],
            ),
          ),
        )
      ],
    );
  }

  Map<String, List> getAllEntities(Iterable<Type> types) {
    return {
      for (final type in types)
        entitiesToPaths[type]!: LocalStorage.getEntities(type)
    };
  }

  Column getGeneratorsColumn(Iterable<Type> types) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: types.map(getGeneratorCard).toList(),
    );
  }

  Column getGeneratorCard(Type entityType) {
    final title = entitiesToPaths[entityType]!;
    final generatorData = generatorsData[title]!;
    final entities = LocalStorage.getEntities(entityType);

    return Column(
      children: [
        GeneratorCard(
          generatorData: GeneratorData(
            generatorPage: SavedEntitiesPage(
              entityType: entityType,
              title: title,
            ),
            title: generatorData.title,
            icon: generatorData.icon,
          ),
          shrink: false,
          disabled: entities.isEmpty,
        ),
        const SizedBox(height: 20)
      ],
    );
  }
}
