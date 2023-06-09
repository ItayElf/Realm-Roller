import 'package:flutter/material.dart';

class DicePanel extends StatelessWidget {
  const DicePanel({super.key, required this.onClick});

  final void Function(int) onClick;

  static const dices = [2, 4, 6, 8, 10, 12, 20, 30, 100];

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 5 / 2,
      children: dices.map((dice) => getDiceButton(context, dice)).toList(),
    );
  }

  Widget getDiceButton(BuildContext context, int dice) => InkWell(
        onTap: () => onClick(dice),
        child: Ink(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Center(
            child: Text(
              "d$dice",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Colors.white),
            ),
          ),
        ),
      );
}
