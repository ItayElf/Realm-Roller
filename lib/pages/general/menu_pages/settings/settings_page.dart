import 'package:flutter/material.dart';
import 'package:realm_roller/custom_widgets/main_menu/menu_paged.dart';
import 'package:realm_roller/pages/general/main_page/background/main_page_background.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainPageBackground(
      currentPage: MenuPage.settings,
    );
  }
}
