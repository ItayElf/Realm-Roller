import 'package:flutter/material.dart';

class DiceResults extends StatelessWidget {
  const DiceResults({
    super.key,
    required this.results,
    required this.diceSize,
  });

  final List<int> results;
  final int diceSize;

  @override
  Widget build(BuildContext context) {
    if (results.isEmpty) {
      return Container();
    }

    final sum = results.reduce((value, element) => value + element);

    return Column(
      children: [
        SelectableText(
          "$sum (${results.length}d$diceSize)",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 24),
        SelectableText(
          results.map((e) => e.toString()).join(", "),
          style: Theme.of(context).textTheme.bodyLarge,
        )
      ],
    );
  }
}
