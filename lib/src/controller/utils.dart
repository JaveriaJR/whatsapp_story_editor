import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';

/// The key needed to capture screenshot of widget
GlobalKey getScreenshotKey = GlobalKey(debugLabel: "image-canvas");

/// Function util to take screenshot of the widget by inputting [GlobalKey]
/// Returns [MemoryImage] of the captured screenshot
Future<MemoryImage> takeScreenshotAndReturnMemoryImage(GlobalKey key) async {
  RenderRepaintBoundary repaintBoundary =
      key.currentContext!.findRenderObject() as RenderRepaintBoundary;
  final image = await repaintBoundary.toImage();
  final byteData = await image.toByteData(format: ImageByteFormat.png);
  return MemoryImage(byteData!.buffer.asUint8List());
}

/// Converts [MemoryImage] to [File]
/// Needed for the package for Cropping Image
Future<File> getFileFromMemoryImage(MemoryImage memoryImage) async {
  final Directory tempDir = await getTemporaryDirectory();
  final String tempPath = tempDir.path;
  final File tempFile = File('$tempPath/image.jpg');
  return await tempFile.writeAsBytes(memoryImage.bytes.toList());
}

/// Sleep Function
Future<void> delayFunction(
    {int seconds = 0,
    int milliseconds = 0,
    int microseconds = 0,
    Function? todo}) async {
  await Future.delayed(
      Duration(
          milliseconds: milliseconds,
          microseconds: microseconds,
          seconds: seconds), () {
    if (todo != null) {
      todo();
    }
  });
}
