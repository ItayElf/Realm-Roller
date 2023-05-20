import 'package:flutter/material.dart';
import 'package:randpg/entities/races.dart';
import 'package:realm_roller/pages/worlds/world_view/stereotypes/stereotype_row.dart';

class StereotypePanel extends StatelessWidget {
  const StereotypePanel({super.key, required this.stereotypes});

  final Map<Race, String> stereotypes;

  @override
  Widget build(BuildContext context) {
    int length = stereotypes.length;
    if (length % 2 == 1) {
      length--;
    }

    final keys = stereotypes.keys.toList();

    return Column(
      children: [
        for (int i = 0; i < length; i += 2) ...[
          StereotypeRow(
            firstRace: keys[i],
            firstStereotype: stereotypes[keys[i]]!,
            secondRace: i < keys.length ? keys[i + 1] : null,
            secondStereotype:
                i < keys.length ? stereotypes[keys[i + 1]]! : null,
          ),
          const SizedBox(height: 20),
        ],
        if (stereotypes.length % 2 != 0) ...[
          StereotypeRow(
            firstRace: stereotypes.keys.last,
            firstStereotype: stereotypes[stereotypes.keys.last]!,
          ),
          const SizedBox(height: 20),
        ]
      ],
    );
  }
}
