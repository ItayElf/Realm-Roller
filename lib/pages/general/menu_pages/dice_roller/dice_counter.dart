import 'package:flutter/material.dart';

class DiceCounter extends StatelessWidget {
  const DiceCounter({
    super.key,
    required this.diceCount,
    required this.onAdd,
    required this.onRemove,
    required this.onAddMany,
    required this.onRemoveMany,
  });

  final int diceCount;
  final Function() onAdd;
  final Function() onRemove;
  final Function() onAddMany;
  final Function() onRemoveMany;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        getButton(context, Icons.exposure_minus_1, onRemove, onRemoveMany),
        Text(
          "$diceCount d",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        getButton(context, Icons.exposure_plus_1, onAdd, onAddMany),
      ],
    );
  }

  Widget getButton(
    BuildContext context,
    IconData icon,
    Function() onTap,
    Function() onLongPress,
  ) =>
      InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        child: Ink(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
        ),
      );
}
