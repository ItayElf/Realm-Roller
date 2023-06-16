import 'package:flutter/material.dart';
import 'package:realm_roller/custom_widgets/main_menu/main_menu_item.dart';
import 'package:realm_roller/custom_widgets/main_menu/menu_paged.dart';
import 'package:realm_roller/custom_widgets/route_builder/route_builder.dart';
import 'package:realm_roller/pages/general/generators_page/generators_page.dart';
import 'package:realm_roller/pages/general/main_page/main_page.dart';
import 'package:realm_roller/pages/general/menu_pages/dice_roller/dice_rollder.dart';
import 'package:realm_roller/pages/general/menu_pages/oracle/oracle_page.dart';
import 'package:realm_roller/pages/general/menu_pages/saved/saved_page.dart';
import 'package:realm_roller/pages/general/menu_pages/settings/settings_page.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key, this.currentPage});

  final MenuPage? currentPage;

  void navigate(BuildContext context, Widget widget) {
    Scaffold.of(context).closeDrawer();
    Navigator.of(context).push(buildRoute(widget));
  }

  void onHome(BuildContext context) => navigate(context, const MainPage());

  void onGenerators(BuildContext context) =>
      navigate(context, const GeneratorsPage());

  void onDiceRoller(BuildContext context) =>
      navigate(context, const DiceRoller());
  void onOracle(BuildContext context) => navigate(context, const OraclePage());
  void onSaved(BuildContext context) => navigate(context, const SavedPage());
  void onSettings(BuildContext context) =>
      navigate(context, const SettingsPage());

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final imageHeight = height * 0.1875;
    final drawerWidth = width * 4 / 5;

    return Drawer(
      backgroundColor: const Color(0xFFFB4236),
      width: drawerWidth,
      child: SizedBox(
        height: height,
        child: Column(
          children: [
            getDrawerImage(context, imageHeight),
            Text(
              "RealmRoller",
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: Colors.white,
                    fontSize: drawerWidth * 0.15,
                  ),
            ),
            SizedBox(
                height: Theme.of(context).textTheme.displayMedium!.fontSize),
            ...getMenuItems()
          ],
        ),
      ),
    );
  }

  Iterable<Widget> getMenuItems() {
    return [
      MainMenuItem(
        title: "Home",
        icon: Icons.home,
        onClick: currentPage != MenuPage.home ? onHome : null,
      ),
      const SizedBox(height: 24),
      MainMenuItem(
        title: "Generators",
        icon: Icons.auto_awesome,
        onClick: currentPage != MenuPage.generators ? onGenerators : null,
      ),
      const SizedBox(height: 24),
      MainMenuItem(
        title: "Dice Roller",
        icon: Icons.casino,
        onClick: currentPage != MenuPage.diceRoller ? onDiceRoller : null,
      ),
      const SizedBox(height: 24),
      MainMenuItem(
        title: "Oracle",
        icon: Icons.self_improvement,
        onClick: currentPage != MenuPage.oracle ? onOracle : null,
      ),
      const SizedBox(height: 24),
      MainMenuItem(
        title: "Saved",
        icon: Icons.favorite,
        onClick: currentPage != MenuPage.saved ? onSaved : null,
      ),
      const SizedBox(height: 24),
      Expanded(child: Container()),
      MainMenuItem(
        icon: Icons.settings,
        title: "Settings",
        onClick: currentPage != MenuPage.settings ? onSettings : null,
      ),
      const SizedBox(height: 16),
    ].map((e) => e is Expanded
        ? e
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: e,
          ));
  }

  Widget getDrawerImage(BuildContext context, double imageHeight) {
    return Stack(
      children: [
        Image.asset(
          "assets/menu.webp",
        ),
        Container(
          width: Theme.of(context).drawerTheme.width,
          height: imageHeight,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0, 0.9),
              end: Alignment.topCenter,
              colors: [
                Color(0xfffb4236),
                Color(0x00fb4236),
              ],
            ),
          ),
        )
      ],
    );
  }
}
