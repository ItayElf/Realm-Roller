import 'package:flutter/material.dart';
import 'package:realm_roller/custom_widgets/entity_pages/entity_page.dart';
import 'package:realm_roller/extensions/entities/names_data.dart';

/// A view for generated names
class NamesView extends StatelessWidget {
  const NamesView({
    super.key,
    required this.namesData,
  });

  final NamesData namesData;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: EntityPage(
          title: "Names",
          subtitle: namesData.description,
          imagePath: namesData.imagePath,
          children: [
            const SizedBox(height: 28),
            ListView.separated(
              itemBuilder: (context, i) => getNameText(
                context,
                namesData.names[i],
              ),
              separatorBuilder: (_, __) => const SizedBox(height: 28),
              itemCount: namesData.names.length,
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
        child: Text(
          name,
          style: Theme.of(context).textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
      );

  // String get subtitle =>
  //     titled("${gender?.name ?? "mixed"} ${race.getPluralName()}");
}
