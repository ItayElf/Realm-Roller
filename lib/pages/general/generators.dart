import 'package:flutter/material.dart';
import 'package:realm_roller/assets_handlers/generators_data.dart';
import 'package:realm_roller/custom_widgets/route_builder/route_builder.dart';

/// A widget that lists all the available generators
class GeneratorsPage extends StatelessWidget {
  const GeneratorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final titles = generatorsData.keys.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Generators"),
        centerTitle: true,
      ),
      body: ListView.separated(
        itemBuilder: (context, i) =>
            _getGeneratorButton(context, generatorsData[titles[i]]!),
        separatorBuilder: (context, i) => const SizedBox(
          height: 24,
        ),
        itemCount: titles.length,
      ),
    );
  }

  Widget _getGeneratorButton(
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
