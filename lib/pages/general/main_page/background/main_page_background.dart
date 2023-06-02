import 'package:flutter/material.dart';
import 'package:realm_roller/custom_widgets/main_menu/main_menu.dart';

class MainPageBackground extends StatelessWidget {
  const MainPageBackground({super.key, this.children});

  final List<Widget>? children;

  static const _buttonSizeMultiplier = 0.12;
  static const _buttonIconMultiplier = 0.09;

  void onMenu(BuildContext context) => Scaffold.of(context).openDrawer();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final buttonSize = width * _buttonSizeMultiplier;
    final columnLocation = buttonSize + 65;
    final columnHeight =
        MediaQuery.of(context).size.height - columnLocation - 157;

    return SafeArea(
      child: Scaffold(
        drawer: const MainMenu(),
        body: Builder(builder: (context) {
          return Stack(
            children: [
              getEllipse(right: -76, top: -200),
              getEllipse(left: -161, bottom: -161),
              getEllipse(right: -124, bottom: -214),
              getMenuButton(context, width),
              Positioned(
                top: columnLocation,
                child: SizedBox(
                  height: columnHeight,
                  child: SingleChildScrollView(
                    child: Column(
                      children: children ?? [],
                    ),
                  ),
                ),
              )
            ],
          );
        }),
      ),
    );
  }

  Positioned getMenuButton(BuildContext context, double width) {
    return Positioned(
      top: 41,
      left: 24,
      child: InkWell(
        onTap: () => onMenu(context),
        child: Container(
          width: width * _buttonSizeMultiplier,
          height: width * _buttonSizeMultiplier,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xfffb4236),
          ),
          child: Icon(
            Icons.menu,
            size: width * _buttonIconMultiplier,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget getEllipse(
          {double? top, double? right, double? bottom, double? left}) =>
      Positioned(
        top: top,
        right: right,
        bottom: bottom,
        left: left,
        child: Container(
          width: 326,
          height: 266,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.elliptical(326, 266)),
            color: Color(0xfffb4236),
          ),
        ),
      );
}
