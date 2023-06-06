import 'package:flutter/material.dart';

class OracleAnswer extends StatelessWidget {
  const OracleAnswer({super.key, required this.answer});

  static const double circularProgressSize = 42;

  final String? answer;

  @override
  Widget build(BuildContext context) {
    if (answer == null) {
      return const SizedBox(
        width: circularProgressSize,
        height: circularProgressSize,
        child: CircularProgressIndicator(),
      );
    }
    return Center(
        child: FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        answer!,
        style: Theme.of(context)
            .textTheme
            .displayMedium!
            .copyWith(color: Colors.black),
      ),
    ));
  }
}
