import 'package:flutter/material.dart';
import 'package:realm_roller/assets_handlers/generators_data.dart';
import 'package:realm_roller/pages/general/main_page/background/main_page_background.dart';
import 'package:realm_roller/pages/general/menu_pages/settings/favorite_generators/favorite_generator_tile.dart';

class FavoriteGeneratorsSettings extends StatelessWidget {
  const FavoriteGeneratorsSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return MainPageBackground(
      children: [
        getTitle(context),
        const SizedBox(height: 24),
        ...generatorsData.keys
            .map((e) => FavoriteGeneratorTile(generatorName: e))
      ],
    );
  }

  Widget getTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 40,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            "Favorite Generators",
            style: Theme.of(context)
                .textTheme
                .displayMedium!
                .copyWith(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
