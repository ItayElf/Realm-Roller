import 'package:flutter/material.dart';
import 'package:realm_roller/assets_handlers/generators_data.dart';
import 'package:realm_roller/custom_widgets/generator_card/generator_card.dart';
import 'package:realm_roller/custom_widgets/main_menu/menu_paged.dart';
import 'package:realm_roller/pages/general/main_page/background/main_page_background.dart';

/// A widget that lists all the available generators
class GeneratorsPage extends StatelessWidget {
  const GeneratorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final titles = generatorsData.keys.toList();

    final left = titles.where((title) => titles.indexOf(title) % 2 == 0);
    final right = titles.where((title) => !left.contains(title));

    return MainPageBackground(
      currentPage: MenuPage.generators,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "Generators",
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

  Column getGeneratorsColumn(Iterable<String> titles) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: titles
          .map(
            (e) => Column(
              children: [
                GeneratorCard(generatorData: generatorsData[e]!, shrink: false),
                const SizedBox(height: 20)
              ],
            ),
          )
          .toList(),
    );
  }
}
