import 'package:flutter/material.dart';
import 'package:randpg/generators.dart';
import 'package:randpg/string_manipulations.dart';
import 'package:realm_roller/custom_widgets/main_menu/menu_paged.dart';
import 'package:realm_roller/pages/general/main_page/background/main_page_background.dart';
import 'package:realm_roller/pages/general/menu_pages/oracle/oracle_answer.dart';
import 'package:realm_roller/pages/general/menu_pages/oracle/oracle_generator.dart';
import 'package:realm_roller/pages/general/menu_pages/oracle/oracle_options.dart';

class OraclePage extends StatefulWidget {
  const OraclePage({super.key});

  @override
  State<OraclePage> createState() => _OraclePageState();
}

class _OraclePageState extends State<OraclePage> {
  String? answer = "?";

  static const delayMin = 200;
  static const delayMax = 700;

  void onOddsClick(OracleOdds odds) {
    setState(() {
      answer = null;
    });
    final newAnswer = OracleGenerator(odds).generate();
    final delay = NumberGenerator(delayMin, delayMax + 1).generate();
    Future.delayed(
      Duration(milliseconds: delay),
      () {
        setState(() {
          answer = titled(newAnswer);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MainPageBackground(
      currentPage: MenuPage.oracle,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Text(
              "Oracle",
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(color: Colors.black),
            ),
          ),
        ),
        const SizedBox(height: 36),
        OracleOptions(onClick: onOddsClick),
        const SizedBox(height: 24),
        SizedBox(
          width: MediaQuery.of(context).size.width - 40,
          child: OracleAnswer(answer: answer),
        )
      ],
    );
  }
}
