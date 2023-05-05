import 'package:flutter/widgets.dart';

/// The background of an entity card
class EntityCardBackground extends StatelessWidget {
  const EntityCardBackground({
    super.key,
    required this.size,
    required this.imagePath,
    this.children,
  });

  final double size;
  final String imagePath;
  final List<Widget>? children;

  static const _gradientStartAlignment = Alignment(0, 0.1);
  static const _gradientEndAlignment = Alignment(0, -1);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        getImageBackground(),
        getGradientBackground(),
        ...(children ?? []),
      ],
    );
  }

  Container getGradientBackground() => Container(
        width: size,
        height: size,
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

  Container getImageBackground() => Container(
        width: size,
        height: size,
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
}
