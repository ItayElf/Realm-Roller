import 'package:flutter/material.dart';
import 'package:randpg/entities/races.dart';
import 'package:randpg/enums/gender.dart';
import 'package:randpg/string_manipulations.dart';
import 'package:realm_roller/assets_handlers/image_path_finders.dart';
import 'package:realm_roller/custom_widgets/entity_pages/entity_page.dart';

/// A view for generated names
class NamesView extends StatelessWidget {
  const NamesView({
    super.key,
    required this.gender,
    required this.race,
    required this.names,
  });

  final Gender? gender;
  final Race race;
  final List<String> names;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: EntityPage(
          title: "Names",
          subtitle: subtitle,
          imagePath: getRaceImage(race),
          children: [
            const SizedBox(height: 28),
            ListView.separated(
              itemBuilder: (context, i) => getNameText(context, names[i]),
              separatorBuilder: (_, __) => const SizedBox(height: 28),
              itemCount: names.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
            ),
            const SizedBox(height: 28),
          ],
        ),
      ),
    );
  }

  Widget getNameText(BuildContext context, String name) => Center(
        child: SelectableText(
          name,
          style: Theme.of(context).textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
      );

  String get subtitle =>
      titled("${gender?.name ?? "mixed"} ${race.getPluralName()}");
}
