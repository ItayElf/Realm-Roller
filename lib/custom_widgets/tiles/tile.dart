import 'package:flutter/material.dart';
import 'package:realm_roller/custom_widgets/tiles/tile_background.dart';

/// A base tile used to display a trailer for an entity
class Tile extends StatelessWidget {
  const Tile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    this.onClick,
  });

  final String title;
  final String subtitle;
  final String imagePath;
  final void Function()? onClick;

  static const _textWidthRatio = 0.615;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: TileBackground(
        imagePath: imagePath,
        children: [
          Positioned(
            top: 8,
            left: 12,
            child: getTextWidget(
              context: context,
              content: title,
              textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.white,
                  ),
            ),
          ),
          Positioned(
            top: 32,
            left: 12,
            child: getTextWidget(
              context: context,
              content: subtitle,
              textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.white,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getTextWidget({
    required TextStyle textStyle,
    required String content,
    required BuildContext context,
  }) =>
      SizedBox(
        width: TileBackground.getTileWidth(context) * _textWidthRatio,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Text(
            content,
            style: textStyle,
          ),
        ),
      );
}
