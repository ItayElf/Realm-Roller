import 'package:flutter/material.dart';
import 'package:realm_roller/custom_widgets/cards/entity_card_background.dart';

/// A card used to display trailer of entities
class EntityCard extends StatelessWidget {
  const EntityCard({
    super.key,
    required this.size,
    required this.title,
    required this.subtitle,
    this.imagePath,
    this.alternativeBackground,
    this.onClick,
  });

  final double size;
  final String title;
  final String subtitle;
  final String? imagePath;
  final Widget? alternativeBackground;
  final void Function(BuildContext)? onClick;

  static const _textPadding = 8.0;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick != null ? () => onClick!(context) : null,
      child: EntityCardBackground(
        size: size,
        imagePath: imagePath,
        alternativeBackground: alternativeBackground,
        children: [
          getTitleText(context),
          getSubtitleText(context),
        ],
      ),
    );
  }

  Positioned getSubtitleText(BuildContext context) => Positioned(
        bottom: 8,
        left: _textPadding,
        child: SizedBox(
          width: size - _textPadding * 2,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.center,
            child: Text(
              subtitle,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Colors.white),
            ),
          ),
        ),
      );

  Positioned getTitleText(BuildContext context) => Positioned(
        bottom: 28,
        left: _textPadding,
        child: SizedBox(
          width: size - _textPadding * 2,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.center,
            child: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Colors.white),
            ),
          ),
        ),
      );
}
