import 'package:flutter/material.dart';
import 'package:realm_roller/custom_widgets/entity_pages/entity_page_background.dart';
import 'package:realm_roller/custom_widgets/entity_pages/entity_page_card.dart';

/// A base widget for an entity page
class EntityPage extends StatefulWidget {
  const EntityPage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    this.children,
  });

  final String title;
  final String subtitle;
  final String imagePath;
  final List<Widget>? children;

  @override
  State<EntityPage> createState() => _EntityPageState();
}

class _EntityPageState extends State<EntityPage> {
  bool isHidden = false;
  late final ScrollController _scrollController;

  static const _cardGap = 96.0;
  static const _scrollOffsetThreshold = 7.0;

  void _scrollListener() {
    if (!isHidden && _scrollController.offset > _scrollOffsetThreshold) {
      setState(() {
        isHidden = !isHidden;
      });
    } else if (isHidden && _scrollController.offset < _scrollOffsetThreshold) {
      setState(() {
        isHidden = !isHidden;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return EntityPageBackground(
      imagePath: widget.imagePath,
      hideButtons: isHidden,
      children: [
        SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              const SizedBox(
                height: _cardGap,
              ),
              EntityPageCard(
                title: widget.title,
                subtitle: widget.subtitle,
                minHeight: MediaQuery.of(context).size.height - _cardGap * 1.25,
                children: widget.children,
              ),
            ],
          ),
        )
      ],
    );
  }
}
