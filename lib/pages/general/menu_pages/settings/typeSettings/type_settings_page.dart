import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:randpg/general.dart';
import 'package:randpg/string_manipulations.dart';
import 'package:realm_roller/assets_handlers/local_storage/saver_data.dart';
import 'package:realm_roller/custom_widgets/main_menu/menu_paged.dart';
import 'package:realm_roller/pages/general/main_page/background/main_page_background.dart';
import 'package:realm_roller/pages/general/menu_pages/settings/typeSettings/type_tile.dart';

class TypeSettingsPage extends StatelessWidget {
  const TypeSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainPageBackground(
      currentPage: MenuPage.settings,
      children: [
        getTitle(context),
        const SizedBox(height: 24),
        ...getManagers().map(
          (e) => SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ExpansionTile(
              title: Text(titledEach(camelCaseToText(
                  e.runtimeType.toString().replaceAll("Manager", "")))),
              children: e.allTypes.map((e) => TypeTile(type: e)).toList(),
            ),
          ),
        )
      ],
    );
  }

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

  String camelCaseToText(String camelCased) {
    final regex = RegExp('(?<=[a-z])[A-Z]');
    return camelCased
        .replaceAllMapped(regex, (m) => " ${m.group(0)}")
        .toLowerCase();
  }

  Iterable<Manager> getManagers() => managersToPaths.keys
      .where((manager) => manager.allTypes.length > 1)
      .sorted(_sortManagers);

  int _sortManagers(Manager<dynamic> a, Manager<dynamic> b) {
    return a.runtimeType.toString().compareTo(b.runtimeType.toString());
  }
}
