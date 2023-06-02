import 'package:flutter/widgets.dart';

/// The background of an entity card
class EntityCardBackground extends StatelessWidget {
  const EntityCardBackground({
    super.key,
    required this.size,
    this.imagePath,
    this.alternativeBackground,
    this.children,
  });

  final double size;
  final String? imagePath;
  final Widget? alternativeBackground;
  final List<Widget>? children;

  static const _gradientStartAlignment = Alignment(0, 0.1);
  static const _gradientEndAlignment = Alignment(0, -1);

  @override
  Widget build(BuildContext context) {
    assert(!(alternativeBackground != null && imagePath != null));

    return Stack(
      children: [
        getBackground(),
        getGradientBackground(),
        ...(children ?? []),
      ],
    );
  }

  Widget getBackground() {
    Widget background;
    if (imagePath != null) {
      background = getImage();
    } else {
      background = alternativeBackground!;
    }

    return Container(
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
        child: background,
      ),
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

  Widget getImage() => Image.asset(
        imagePath!,
        fit: BoxFit.cover,
      );
}
