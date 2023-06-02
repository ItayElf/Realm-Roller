import 'package:flutter/material.dart';
import 'package:realm_roller/custom_widgets/main_menu/menu_paged.dart';
import 'package:realm_roller/pages/general/main_page/background/main_page_background.dart';
import 'package:realm_roller/pages/general/main_page/favorite_generators/favorite_generators.dart';
import 'package:realm_roller/pages/general/main_page/featured_entities/featured_entities.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainPageBackground(
      currentPage: MenuPage.home,
      children: [
        getPageTitle(context),
        const SizedBox(height: 36),
        const FavoriteGenerators(),
        const SizedBox(height: 36),
        const FeaturedEntities()
      ],
    );
  }

  Padding getPageTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome!",
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(color: Colors.black),
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "What would you like to generate?",
                maxLines: 1,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
