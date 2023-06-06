import 'package:flutter/material.dart';
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
  String? answer = "Exceptional no";

  void onOddsClick(OracleOdds odds) {}

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
