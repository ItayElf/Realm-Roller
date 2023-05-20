import 'package:flutter/material.dart';
import 'package:randpg/entities/races.dart';
import 'package:randpg/string_manipulations.dart';

class StereotypeCard extends StatelessWidget {
  const StereotypeCard({
    super.key,
    required this.race,
    required this.stereotype,
  });

  final Race race;
  final String stereotype;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).primaryColor,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            titled(race.getPluralName()),
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: Theme.of(context).primaryColor),
          ),
          const SizedBox(height: 4),
          Flexible(
            child: Text(
              titled(stereotype),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
              maxLines: 3,
            ),
          ),
        ],
      ),
    );
  }
}
