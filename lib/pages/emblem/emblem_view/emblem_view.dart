import 'package:flutter/material.dart';
import 'package:randpg/entities/emblems.dart';
import 'package:realm_roller/assets_handlers/image_path_finders.dart';
import 'package:realm_roller/custom_widgets/emblem_viewer/emblem_viewer.dart';
import 'package:realm_roller/custom_widgets/entity_pages/entity_page.dart';
import 'package:realm_roller/pages/emblem/emblem_view/emblem_download_button.dart';

class EmblemView extends StatelessWidget {
  const EmblemView({super.key, required this.emblem, this.fileName});

  final Emblem emblem;
  final String? fileName;

  static const scale = 2.8;

  @override
  Widget build(BuildContext context) {
    final scale = MediaQuery.of(context).size.width / 150;

    return SafeArea(
      child: Material(
        child: EntityPage(
          title: "Emblem",
          subtitle: "",
          imagePath: getEmblemImage(emblem),
          entity: emblem,
          children: [
            EmblemViewer(
              emblem: emblem,
              scale: scale,
            ),
            Center(
              child: EmblemDownloadButton(
                emblem: emblem,
                filename: fileName,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
