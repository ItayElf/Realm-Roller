import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:randpg/entities/emblems.dart';

const downloadsPath = "/storage/emulated/0/Download/";

Future<bool> _doesHavePermissions() async {
  if (Platform.isAndroid) {
    final androidInfo = await DeviceInfoPlugin().androidInfo;
    if (androidInfo.version.sdkInt <= 32) {
      return await Permission.storage.request().isGranted;
    } else {
      return await Permission.photos.request().isGranted;
    }
  }
  return false;
}

Future<void> saveEmblem(
    BuildContext context, Emblem emblem, String fileName) async {
  if (!await _doesHavePermissions()) {
    if (!context.mounted) {
      return;
    }
    showDialog(
      context: context,
      builder: (context) => errorDialogBuilder(context, fileName),
    );
    return;
  }

  final svgContent = emblem.buildSvg();

  final tempFile = File("$downloadsPath/$fileName.svg");
  await tempFile.writeAsString(svgContent);

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

Widget errorDialogBuilder(BuildContext context, String error) {
  return AlertDialog(
    title: const Text("Error"),
    content: Text(
      error,
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
