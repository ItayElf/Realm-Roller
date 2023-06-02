import 'package:flutter/material.dart';
import 'package:realm_roller/assets_handlers/generators_data.dart';
import 'package:realm_roller/custom_widgets/route_builder/route_builder.dart';

class GeneratorCard extends StatelessWidget {
  const GeneratorCard({super.key, required this.generatorData});

  final GeneratorData generatorData;

  void onClick(BuildContext context, GeneratorData generatorData) =>
      Navigator.of(context).push(buildRoute(generatorData.generatorPage));

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onClick(context, generatorData),
      child: Ink(
        padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(children: [
          Icon(
            generatorData.icon,
            size: Theme.of(context).textTheme.titleMedium!.fontSize,
            color: Colors.white,
          ),
          const SizedBox(width: 12),
          Text(
            generatorData.title,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: Colors.white),
          ),
        ]),
      ),
    );
  }
}
