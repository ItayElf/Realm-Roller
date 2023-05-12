import 'package:flutter/material.dart';

/// The title of an expanded paragraph
class ExpandedParagraphTitle extends StatelessWidget {
  const ExpandedParagraphTitle({
    super.key,
    required this.title,
    required this.icon,
    required this.isExpanded,
  });

  final String title;
  final IconData icon;
  final bool isExpanded;

  static const _animationDuration = Duration(milliseconds: 250);
  static const _iconSizeMultiplier = 0.07;

  static const _padding = 20.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - _padding * 2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          getTitleText(context),
          AnimatedRotation(
            turns: isExpanded ? 0 : 0.5,
            duration: _animationDuration,
            child: Icon(
              Icons.expand_more,
              size: getIconSize(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget getTitleText(BuildContext context) {
    return IntrinsicWidth(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(
                icon,
                size: getIconSize(context),
                color: const Color(0xFFFB4236),
              ),
              const SizedBox(width: 5),
              Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall,
              )
            ],
          ),
          const SizedBox(height: 2),
          Container(
            height: 1,
            color: Theme.of(context).primaryColor,
          )
        ],
      ),
    );
  }

  double getIconSize(BuildContext context) =>
      MediaQuery.of(context).size.width * _iconSizeMultiplier;
}
