import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// The background of a tile
class TileBackground extends StatelessWidget {
  const TileBackground({
    super.key,
    required this.imagePath,
    this.children,
  });

  final String imagePath;
  final List<Widget>? children;

  static const _tileHeight = 58.0;
  static const _tilePadding = 20.0;
  static const _gradientStartAlignment = Alignment(0.16, 0);
  static const _gradientEndAlignment = Alignment(1, 0);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        getImageBackground(context),
        getGradientBackground(context),
        ...(children ?? []),
      ],
    );
  }

  Widget getImageBackground(BuildContext context) => Container(
        width: getTileWidth(context),
        height: _tileHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              blurRadius: 4,
              offset: Offset(0, 4),
              color: Color(0x40000000),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
          ),
        ),
      );

  Widget getGradientBackground(BuildContext context) => Container(
        width: getTileWidth(context),
        height: _tileHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: const LinearGradient(
            begin: _gradientStartAlignment,
            end: _gradientEndAlignment,
            colors: [
              Color(0xfffb4236),
              Color(0x00FB4236),
            ],
          ),
        ),
      );

  static double getTileWidth(BuildContext context) =>
      MediaQuery.of(context).size.width - _tilePadding * 2;
}
