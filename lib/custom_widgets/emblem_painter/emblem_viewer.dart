import 'package:drop_shadow/drop_shadow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:randpg/entities/emblems.dart';
import 'package:widget_mask/widget_mask.dart';

import 'emblem_saver.dart';

class EmblemViewer extends StatelessWidget {
  const EmblemViewer({super.key, required this.emblem, required this.fileName});

  final Emblem emblem;
  final String fileName;

  static const scale = 1.2;
  static const double _width = 120 * scale;
  static const double _height = 150 * scale;

  static const _baseIconsColor = "red";
  static const _basePrimaryColor = "#000";
  static const _baseSecondaryColor = "#fff";

  @override
  Widget build(BuildContext context) {
    final globalKey = GlobalKey();

    return Center(
      child: InkWell(
        onLongPress: () => saveEmblem(context, emblem, fileName),
        child: RepaintBoundary(
          key: globalKey,
          child: Stack(
            children: [
              getEmblemShape(),
              ...emblem.icons.map(getIconFromData),
            ],
          ),
        ),
      ),
    );
  }

  Positioned getIconFromData(EmblemIcon iconData) {
    return Positioned(
      left: iconData.position.x * scale,
      top: iconData.position.y * scale + 8,
      child: SvgPicture.string(
        iconData.svgWrapper
            .recolored({_baseIconsColor: toRgb(emblem.iconsColor)}).content,
        width: iconData.position.size * scale,
        height: iconData.position.size * scale,
      ),
    );
  }

  Widget getEmblemShape() {
    return DropShadow(
      blurRadius: 2,
      color: Colors.black.withOpacity(0.25),
      child: WidgetMask(
        childSaveLayer: true,
        blendMode: BlendMode.dstIn,
        mask: SvgPicture.string(
          emblem.shape.content,
          width: _width,
          height: _height,
        ),
        child: SvgPicture.string(
          emblem.pattern.recolored({
            _basePrimaryColor: toRgb(emblem.primaryColor),
            _baseSecondaryColor: toRgb(emblem.secondaryColor),
          }).content,
          width: _width,
          height: _height,
        ),
      ),
    );
  }

  String toRgb(HslColor color) {
    final map = color.getRGBMap().map(
        (key, value) => MapEntry(key, value.toRadixString(16).padLeft(2, "0")));
    return "#${map["r"]}${map["g"]}${map["b"]}";
  }
}
