import 'package:flutter/material.dart';
import 'package:realm_roller/custom_widgets/main_menu/menu_paged.dart';
import 'package:realm_roller/custom_widgets/route_builder/route_builder.dart';
import 'package:realm_roller/pages/general/main_page/background/main_page_background.dart';
import 'package:realm_roller/pages/general/menu_pages/settings/favorite_generators/favorite_generators_settings.dart';
import 'package:realm_roller/pages/general/menu_pages/settings/typeSettings/type_settings_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainPageBackground(
      currentPage: MenuPage.settings,
      children: [
        getTitle(context),
        const SizedBox(height: 24),
        getSettingsButton(
            context, "Favorite Generators", const FavoriteGeneratorsSettings()),
        const SizedBox(height: 16),
        getSettingsButton(context, "Used Types", const TypeSettingsPage()),
      ],
    );
  }

  Widget getSettingsButton(
          BuildContext context, String title, Widget onClick) =>
      SizedBox(
        width: MediaQuery.of(context).size.width - 40,
        child: ElevatedButton(
          onPressed: () => Navigator.of(context).push(buildRoute(onClick)),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Theme.of(context).primaryColor,
          ),
          child: Center(child: Text(title)),
        ),
      );

  SizedBox getTitle(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Text(
          "Settings",
          style: Theme.of(context)
              .textTheme
              .displayMedium!
              .copyWith(color: Colors.black),
        ),
      ),
    );
  }
}
