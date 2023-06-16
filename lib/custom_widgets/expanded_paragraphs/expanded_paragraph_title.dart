import 'package:flutter/material.dart';

/// The title of an expanded paragraph
class ExpandedParagraphTitle extends StatelessWidget {
  const ExpandedParagraphTitle({
    super.key,
    required this.title,
    required this.icon,
  });

  final String title;
  final IconData icon;

  static const _iconSizeMultiplier = 0.07;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: getTitleText(context),
    );
  }

  Widget getTitleText(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: "",
        style: Theme.of(context).textTheme.headlineSmall,
        children: [
          WidgetSpan(
            child: Icon(
              icon,
              size: getIconSize(context),
              color: const Color(0xFFFB4236),
            ),
          ),
          const WidgetSpan(child: SizedBox(width: 5)),
          TextSpan(
            text: title,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }

  double getIconSize(BuildContext context) =>
      MediaQuery.of(context).size.width * _iconSizeMultiplier;
}
