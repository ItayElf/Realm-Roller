import 'dart:math';

import 'package:flutter/material.dart';
import 'package:randpg/generators.dart';
import 'package:realm_roller/custom_widgets/main_menu/menu_paged.dart';
import 'package:realm_roller/pages/general/main_page/background/main_page_background.dart';
import 'package:realm_roller/pages/general/menu_pages/dice_roller/dice_counter.dart';
import 'package:realm_roller/pages/general/menu_pages/dice_roller/dice_panel.dart';
import 'package:realm_roller/pages/general/menu_pages/dice_roller/dice_results.dart';

class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});

  @override
  State<DiceRoller> createState() => _DiceRollerState();
}

class _DiceRollerState extends State<DiceRoller> {
  List<int> results = [];
  int dices = 1;
  int diceSize = 1;

  void onAdd() => setState(() {
        dices++;
      });

  void onRemove() => setState(() {
        dices = max(dices - 1, 1);
      });

  void onAddMany() => setState(() {
        dices += 5;
      });

  void onRemoveMany() => setState(() {
        dices = max(dices - 5, 1);
      });

  void onRoll(int chosenDiceSize) {
    final generator =
        RepeatedGenerator(NumberGenerator(1, chosenDiceSize), dices);
    setState(() {
      results = generator.generate();
      diceSize = chosenDiceSize;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainPageBackground(
      currentPage: MenuPage.diceRoller,
      children: [
        getTitle(context),
        const SizedBox(height: 36),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            width: MediaQuery.of(context).size.width - 40,
            child: Column(
              children: [
                DiceCounter(
                  diceCount: dices,
                  onAdd: onAdd,
                  onRemove: onRemove,
                  onAddMany: onAddMany,
                  onRemoveMany: onRemoveMany,
                ),
                const SizedBox(height: 24),
                DicePanel(onClick: onRoll),
                const SizedBox(height: 24),
                DiceResults(results: results, diceSize: diceSize),
              ],
            ),
          ),
        ),
      ],
    );
  }

  SizedBox getTitle(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Text(
          "Dice Roller",
          style: Theme.of(context)
              .textTheme
              .displayMedium!
              .copyWith(color: Colors.black),
        ),
      ),
    );
  }
}
