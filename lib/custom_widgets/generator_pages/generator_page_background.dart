import 'package:flutter/material.dart';

/// The background of a generator page
class GeneratorPageBackground extends StatelessWidget {
  const GeneratorPageBackground({super.key, this.onGenerate, this.children});

  final void Function()? onGenerate;
  final List<Widget>? children;

  static const _buttonSizeMultiplier = 0.12;
  static const _buttonIconMultiplier = 0.09;

  void onBack(BuildContext context) => Navigator.pop(context);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        getTopEllipse(),
        getLeftEllipse(),
        getRightEllipse(),
        Positioned(
          top: 41,
          left: 24,
          child: InkWell(
            onTap: () => onBack(context),
            child: Icon(
              Icons.arrow_back,
              size: width * _buttonIconMultiplier,
            ),
          ),
        ),
        Positioned(
          right: 24,
          bottom: 189,
          child: Row(
            children: [
              SelectableText(
                "Generate!",
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(color: Colors.black),
              ),
              const SizedBox(width: 12),
              getGenerateButton(width),
            ],
          ),
        ),
        ...(children ?? []),
      ],
    );
  }

  InkWell getGenerateButton(double width) {
    return InkWell(
      onTap: onGenerate,
      child: Container(
        width: width * _buttonSizeMultiplier,
        height: width * _buttonSizeMultiplier,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xfffb4236),
        ),
        child: Icon(
          Icons.arrow_forward,
          size: width * _buttonIconMultiplier,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget getRightEllipse() {
    return getEllipse(bottom: -153, right: -139);
  }

  Widget getLeftEllipse() {
    return getEllipse(bottom: -101, left: -146);
  }

  Widget getTopEllipse() {
    return getEllipse(top: -213, right: -76);
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
