import 'package:flutter/material.dart';
import 'package:realm_roller/custom_widgets/main_menu/menu_paged.dart';
import 'package:realm_roller/pages/general/main_page/background/main_page_background.dart';
import 'package:realm_roller/pages/general/menu_pages/oracle/oracle_generator.dart';
import 'package:realm_roller/pages/general/menu_pages/oracle/oracle_options.dart';

class OraclePage extends StatelessWidget {
  const OraclePage({super.key});

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
        OracleOptions(
          onClick: onOddsClick,
        ),
      ],
    );
  }
}
