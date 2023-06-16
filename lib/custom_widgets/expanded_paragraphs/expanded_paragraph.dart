import 'package:flutter/material.dart';
import 'package:realm_roller/custom_widgets/expanded_paragraphs/expanded_paragraph_title.dart';

/// A paragraph that expands and shrink on tap
class ExpandedParagraph extends StatelessWidget {
  const ExpandedParagraph({
    super.key,
    required this.title,
    required this.icon,
    this.child,
  });

  final String title;
  final IconData icon;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        initiallyExpanded: true,
        tilePadding: const EdgeInsets.all(0),
        expandedAlignment: Alignment.centerLeft,
        title: ExpandedParagraphTitle(
          title: title,
          icon: icon,
        ),
        children: child != null ? [child!] : [],
      ),
    );
  }
}
