import 'package:flutter/material.dart';
import 'package:realm_roller/custom_widgets/entity_pages/entity_page_menu.dart';

/// The background of an entity page
class EntityPageBackground extends StatelessWidget {
  const EntityPageBackground({
    super.key,
    required this.imagePath,
    required this.hideButtons,
    this.children,
  });

  final String imagePath;
  final bool hideButtons;
  final List<Widget>? children;

  static const _buttonSizeMultiplier = 0.12;
  static const _buttonIconMultiplier = 0.09;
  static const _animationDuration = Duration(milliseconds: 200);

  void onBack(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        SizedBox(
          width: width,
          height: height,
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
          ),
        ),
        ...(children ?? []),
        Positioned(
          top: 32,
          left: 24,
          child: getBackButton(context, width),
        ),
        Positioned(
          top: 32,
          right: 24,
          child: getHiddenWidget(
            widget: EntityPageMenu(
              buttonSize: width * _buttonSizeMultiplier,
              iconSize: width * _buttonIconMultiplier,
            ),
          ),
        ),
      ],
    );
  }

  Widget getBackButton(BuildContext context, double width) {
    return getHiddenWidget(
      widget: InkWell(
        onTap: () => onBack(context),
        child: Container(
          width: width * _buttonSizeMultiplier,
          height: width * _buttonSizeMultiplier,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Icon(
            Icons.arrow_back,
            size: width * _buttonIconMultiplier,
          ),
        ),
      ),
    );
  }

  Widget getHiddenWidget({required Widget widget}) {
    return AnimatedScale(
      duration: _animationDuration,
      scale: hideButtons ? 0 : 1,
      child: widget,
    );
  }
}
