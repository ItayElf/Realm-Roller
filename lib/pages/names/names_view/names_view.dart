import 'package:flutter/material.dart';
import 'package:realm_roller/custom_widgets/entity_pages/entity_page.dart';

/// A view for generated names
class NamesView extends StatelessWidget {
  const NamesView({
    super.key,
    required this.imagePath,
    required this.subtitle,
    required this.names,
  });

  final String imagePath;
  final String subtitle;
  final List<String> names;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: EntityPage(
          title: "Names",
          subtitle: subtitle,
          imagePath: imagePath,
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

  // String get subtitle =>
  //     titled("${gender?.name ?? "mixed"} ${race.getPluralName()}");
}
