import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:randpg/entities/emblems.dart';

const downloadsPath = "/storage/emulated/0/Download/";

Future<void> saveEmblem(
    BuildContext context, Emblem emblem, String fileName) async {
  if (!await Permission.storage.request().isGranted) {
    return;
  }

  final svgContent = emblem.buildSvg();

  final tempFile = File("$downloadsPath/$fileName.svg");
  await tempFile.writeAsString(svgContent);

  // ignore: use_build_context_synchronously
  if (!context.mounted) {
    return;
  }

  showDialog(
    context: context,
    builder: (context) => dialogBuilder(context, fileName),
  );
}

Widget dialogBuilder(BuildContext context, String fileName) {
  return AlertDialog(
    title: const Text("File saved successfully"),
    content: Text(
      "File \"$fileName.svg\" was saved to downloads",
      style: Theme.of(context).textTheme.bodyLarge,
    ),
    actions: [
      TextButton(
        child: const Text("OK"),
        onPressed: () {
          Navigator.of(context, rootNavigator: true).pop('dialog');
        },
      ),
    ],
  );
}
