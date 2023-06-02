import 'package:flutter/material.dart';
import 'package:realm_roller/assets_handlers/generators_data.dart';
import 'package:realm_roller/custom_widgets/route_builder/route_builder.dart';
import 'package:realm_roller/pages/general/main_page/background/main_page_background.dart';

/// A widget that lists all the available generators
class GeneratorsPage extends StatelessWidget {
  const GeneratorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final titles = generatorsData.keys.toList();

    return MainPageBackground(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "Generators",
            style: Theme.of(context)
                .textTheme
                .displayMedium!
                .copyWith(color: Colors.black),
          ),
        ),
      ],
    );
  }

  Widget getGeneratorButton(
          BuildContext context, GeneratorData generatorData) =>
      ElevatedButton(
          onPressed: () => Navigator.of(context)
              .push(buildRoute(generatorData.generatorPage)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(generatorData.icon),
              Text(
                generatorData.title,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Colors.white),
              ),
            ],
          ));
}
