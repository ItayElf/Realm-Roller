import 'package:flutter/material.dart';
import 'package:randpg/entities/emblems.dart';
import 'package:realm_roller/custom_widgets/emblem_viewer/emblem_saver.dart';

class EmblemDownloadButton extends StatefulWidget {
  const EmblemDownloadButton({super.key, this.filename, required this.emblem});

  final String? filename;
  final Emblem emblem;

  @override
  State<EmblemDownloadButton> createState() => _EmblemDownloadButtonState();
}

class _EmblemDownloadButtonState extends State<EmblemDownloadButton> {
  bool isActive = true;

  void onClick(BuildContext context) async {
    setState(() {
      isActive = false;
    });

    final filename =
        widget.filename ?? DateTime.now().millisecondsSinceEpoch.toString();

    await saveEmblem(context, widget.emblem, filename);

    setState(() {
      isActive = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isActive ? () => onClick(context) : null,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            isActive
                ? const Icon(
                    Icons.download,
                    size: 36,
                  )
                : CircularProgressIndicator(
                    color: Theme.of(context).disabledColor,
                  ),
            const SizedBox(width: 4),
            Text(
              "Download",
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
