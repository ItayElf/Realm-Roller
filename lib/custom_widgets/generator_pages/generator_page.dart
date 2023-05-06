import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:realm_roller/custom_widgets/generator_pages/generator_page_background.dart';

/// A page used for generating entities
class GeneratorPage extends StatelessWidget {
  const GeneratorPage({
    super.key,
    required this.title,
    this.onGenerate,
    this.children,
  });

  final String title;
  final void Function()? onGenerate;
  final List<Widget>? children;

  static const _padding = 24.0;

  @override
  Widget build(BuildContext context) {
    return GeneratorPageBackground(
      onGenerate: onGenerate,
      children: [
        Positioned(
          top: 100,
          left: _padding,
          child: SizedBox(
            width: MediaQuery.of(context).size.width - _padding * 2,
            child: Column(
              children: [
                getTitleText(context),
                const SizedBox(height: 6),
                Container(
                  height: 1,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(height: 28),
                ...(children ?? []),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget getTitleText(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - _padding * 2,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: SelectableText(
          title,
          style: Theme.of(context)
              .textTheme
              .displaySmall!
              .copyWith(color: Colors.black),
        ),
      ),
    );
  }
}
