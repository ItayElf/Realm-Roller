import 'package:flutter/material.dart';

/// The menu expandable button of the entity page
class EntityPageMenu extends StatefulWidget {
  const EntityPageMenu({
    super.key,
    required this.buttonSize,
    required this.iconSize,
    this.onEdit,
    this.onSave,
    this.isSaved = false,
  });

  final double buttonSize;
  final double iconSize;
  final void Function()? onEdit;
  final void Function(bool isSaved)? onSave;
  final bool isSaved;

  @override
  State<EntityPageMenu> createState() => _EntityPageMenuState();
}

class _EntityPageMenuState extends State<EntityPageMenu> {
  late bool isLiked;
  bool isOpen = false;

  static const _animationDuration = Duration(milliseconds: 150);

  void onMenuClick() => setState(() {
        isOpen = !isOpen;
      });

  void onLikeClick() {
    if (widget.onSave != null) {
      widget.onSave!(!isLiked);
    }
    setState(() {
      isLiked = !isLiked;
    });
  }

  @override
  void initState() {
    super.initState();
    isLiked = widget.isSaved;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        AnimatedSlide(
          duration: _animationDuration,
          offset: isOpen ? const Offset(0, 0) : const Offset(1.43 * 2, 0),
          child: getMenuButton(
            onClick: onLikeClick,
            backgroundColor: Colors.white,
            iconColor: const Color(0xFFDF000B),
            icon: isLiked ? Icons.favorite : Icons.favorite_border,
          ),
        ),
        const SizedBox(width: 20),
        AnimatedSlide(
          duration: _animationDuration,
          offset: isOpen ? const Offset(0, 0) : const Offset(1.43, 0),
          child: getMenuButton(
            onClick: widget.onEdit,
            backgroundColor: const Color(0xFFDF000B),
            iconColor: Colors.white,
            icon: Icons.edit,
          ),
        ),
        const SizedBox(width: 20),
        AnimatedSwitcher(
          duration: _animationDuration,
          switchOutCurve: Curves.easeInOutCubic,
          switchInCurve: Curves.fastLinearToSlowEaseIn,
          transitionBuilder: (child, animation) => ScaleTransition(
            scale: animation,
            child: child,
          ),
          child: getMenuButton(
            key: UniqueKey(),
            onClick: onMenuClick,
            backgroundColor: isOpen ? Colors.white : const Color(0xFFDF000B),
            iconColor: isOpen ? Colors.black : Colors.white,
            icon: isOpen ? Icons.close : Icons.menu,
          ),
        ),
      ],
    );
  }

  Widget getMenuButton({
    required void Function()? onClick,
    required Color backgroundColor,
    required Color iconColor,
    required IconData icon,
    Key? key,
  }) =>
      InkWell(
        key: key,
        onTap: onClick,
        child: Container(
          width: widget.buttonSize,
          height: widget.buttonSize,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: backgroundColor,
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: widget.iconSize,
          ),
        ),
      );
}
