import 'package:flutter/material.dart';
import 'package:randpg/entities/races.dart';
import 'package:realm_roller/pages/worlds/world_view/stereotypes/stereotype_card.dart';

class StereotypeRow extends StatelessWidget {
  const StereotypeRow({
    super.key,
    required this.firstRace,
    required this.firstStereotype,
    this.secondRace,
    this.secondStereotype,
  });

  final Race firstRace;
  final String firstStereotype;
  final Race? secondRace;
  final String? secondStereotype;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: StereotypeCard(
                race: firstRace,
                stereotype: firstStereotype,
              ),
            ),
            const SizedBox(width: 20),
            if (secondRace != null && secondStereotype != null)
              Expanded(
                child: StereotypeCard(
                  race: secondRace!,
                  stereotype: secondStereotype!,
                ),
              )
            else
              Expanded(
                child: Container(),
              ),
          ],
        ),
      ),
    );
  }
}
