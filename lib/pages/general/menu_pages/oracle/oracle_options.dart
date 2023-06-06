import 'package:flutter/material.dart';
import 'package:randpg/string_manipulations.dart';
import 'package:realm_roller/pages/general/menu_pages/oracle/oracle_generator.dart';

class OracleOptions extends StatelessWidget {
  const OracleOptions({super.key, required this.onClick});

  final void Function(OracleOdds) onClick;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: OracleOdds.values
            .map(
              (e) => Column(
                children: [
                  getOddsCard(context, e),
                  const SizedBox(height: 4),
                ],
              ),
            )
            .toList(),
      ),
    );
  }

  Widget getOddsCard(BuildContext context, OracleOdds odds) => SizedBox(
        width: MediaQuery.of(context).size.width - 40,
        child: InkWell(
          onTap: () => onClick(odds),
          child: Ink(
            padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: getButtonText(odds, context),
          ),
        ),
      );

  Center getButtonText(OracleOdds odds, BuildContext context) {
    return Center(
      child: Text(
        titled(camelCaseToText(odds.name)),
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: Colors.white),
      ),
    );
  }

  String camelCaseToText(String camelCased) {
    final regex = RegExp('(?<=[a-z])[A-Z]');
    return camelCased
        .replaceAllMapped(regex, (m) => " ${m.group(0)}")
        .toLowerCase();
  }
}
