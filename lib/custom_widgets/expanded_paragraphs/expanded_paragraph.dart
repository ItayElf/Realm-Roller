import 'package:flutter/material.dart';
import 'package:realm_roller/custom_widgets/expanded_paragraphs/expanded_paragraph_title.dart';

/// A paragraph that expands and shrink on tap
class ExpandedParagraph extends StatefulWidget {
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
  State<ExpandedParagraph> createState() => _ExpandedParagraphState();
}

class _ExpandedParagraphState extends State<ExpandedParagraph> {
  bool isExpanded = true;

  static const _animationDuration = Duration(milliseconds: 250);

  void onClick() => setState(() {
        isExpanded = !isExpanded;
      });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onClick,
          child: ExpandedParagraphTitle(
            title: widget.title,
            icon: widget.icon,
            isExpanded: isExpanded,
          ),
        ),
        const SizedBox(height: 6),
        if (widget.child != null) getExpandedChild(widget.child!),
      ],
    );
  }

  Widget getExpandedChild(Widget child) => AnimatedSwitcher(
        duration: _animationDuration,
        transitionBuilder: (child, animation) => ScaleTransition(
          alignment: Alignment.topCenter,
          scale: animation,
          child: child,
        ),
        child: isExpanded ? child : Container(),
      );
}
