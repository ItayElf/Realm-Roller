import 'package:flutter/material.dart';
import 'package:randpg/entities/worlds.dart';

class WorldLoreView extends StatelessWidget {
  const WorldLoreView(
      {super.key, required this.worldLore, required this.worldName});

  final WorldLore worldLore;
  final String worldName;

  @override
  Widget build(BuildContext context) {
    return Text(
      content.replaceAll("\n", "\n\n"),
      style: Theme.of(context).textTheme.bodyLarge,
      textAlign: TextAlign.justify,
    );
  }

  String get content =>
      "In $worldName, it is common knowledge that ${worldLore.everybodyKnows}, although only a selected few are aware "
      "of the fact that ${worldLore.fewKnow}.\n"
      "Almost nobody in $worldName has any knowledge that ${worldLore.nobodyKnows}.\n"
      "The peasants of $worldName are convinced that ${worldLore.peasantsBelieve}, while the nobility tends to believe "
      "that ${worldLore.nobilityBelieves}.\n"
      "The gods of $worldName plan ${worldLore.godsPlan}, but they also harbor a fear of ${worldLore.godsFear}.";
}
