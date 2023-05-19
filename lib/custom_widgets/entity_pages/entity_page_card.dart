import 'package:flutter/material.dart';

/// The card that holds the content in the entity page
class EntityPageCard extends StatelessWidget {
  const EntityPageCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.minHeight,
    this.children,
  });

  final String title;
  final String subtitle;
  final double minHeight;
  final List<Widget>? children;

  @override
  Widget build(BuildContext context) {
    return getContentCard(context);
  }

  Widget getContentCard(BuildContext context) {
    final decorations = BoxDecoration(
      color: const Color(0xe6ffffff),
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
      border: Border.all(color: const Color(0xFFF26861), width: 2),
    );

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
      constraints: BoxConstraints(
        minHeight: minHeight,
      ),
      decoration: decorations,
      child: SelectionArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getTitleText(context),
            const SizedBox(height: 5),
            getSubtitleText(context),
            const SizedBox(height: 5),
            Container(
              height: 1,
              width: MediaQuery.of(context).size.width,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(height: 5),
            ...(children ?? []),
          ],
        ),
      ),
    );
  }

  Widget getTitleText(BuildContext context) {
    return Center(
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: SelectableText(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .displaySmall!
              .copyWith(color: Colors.black),
        ),
      ),
    );
  }

  Widget getSubtitleText(BuildContext context) {
    return Center(
      child: SelectableText(
        subtitle,
        textAlign: TextAlign.center,
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: Colors.black),
      ),
    );
  }
}
