import 'package:flutter/material.dart';
import 'package:realm_roller/custom_widgets/menu/main_menu_item.dart';
import 'package:realm_roller/custom_widgets/route_builder/route_builder.dart';
import 'package:realm_roller/pages/general/generators.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  void onGenerators(BuildContext context) =>
      Navigator.of(context).push(buildRoute(const GeneratorsPage()));

  void onDiceRoller(BuildContext context) {}
  void onOracle(BuildContext context) {}
  void onSaved(BuildContext context) {}
  void onSettings(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final imageHeight = height * 0.1875;
    final drawerWidth = width * 3 / 4;

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
            const SizedBox(height: 32),
            ...getMenuItems()
          ],
        ),
      ),
    );
  }

  Iterable<Widget> getMenuItems() {
    return [
      MainMenuItem(
        title: "Generators",
        icon: Icons.auto_awesome,
        onClick: onGenerators,
      ),
      const SizedBox(height: 24),
      MainMenuItem(
        title: "Dice Roller",
        icon: Icons.casino,
        onClick: onDiceRoller,
      ),
      const SizedBox(height: 24),
      MainMenuItem(
        title: "Oracle",
        icon: Icons.self_improvement,
        onClick: onDiceRoller,
      ),
      const SizedBox(height: 24),
      MainMenuItem(
        title: "Saved",
        icon: Icons.favorite,
        onClick: onDiceRoller,
      ),
      const SizedBox(height: 24),
      Expanded(child: Container()),
      MainMenuItem(
        icon: Icons.settings,
        title: "Settings",
        onClick: onSettings,
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
