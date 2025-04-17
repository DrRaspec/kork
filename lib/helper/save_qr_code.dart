import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:kork/models/event_model.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_saver/file_saver.dart';

Future<void> saveQrCode(GlobalKey key, BoughtTicket ticket) async {
  try {
    // Check storage permission
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
      status = await Permission.storage.status;
      if (!status.isGranted) {
        Get.snackbar(
          'Permission Denied',
          'Storage permission is required to save QR code',
          snackPosition: SnackPosition.TOP,
        );
        return;
      }
    }

    // Validate context
    if (key.currentContext == null) {
      Get.snackbar(
        'Error',
        'QR code is not ready yet. Please try again.',
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    // Render QR code
    RenderRepaintBoundary boundary =
    key.currentContext!.findRenderObject() as RenderRepaintBoundary;

    // Generate image with higher quality
    ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    ByteData? byteData =
    await image.toByteData(format: ui.ImageByteFormat.png);

    if (byteData != null) {
      Uint8List pngBytes = byteData.buffer.asUint8List();

      // Get temporary directory
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/QR_${ticket.event.eventName}.png');

      // Write to temporary file
      await file.writeAsBytes(pngBytes);

      // Use file_saver directly with the file path
      final result = await FileSaver.instance.saveAs(
        name: "QR_${ticket.event.eventName}",
        ext: "png",
        filePath: file.path,
        mimeType: MimeType.png,
      );

      // print('File saved result: $result');

      Get.snackbar(
        'Success',
        'QR code saved! Check your Downloads folder.',
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
      );
    } else {
      throw Exception('Failed to generate image data');
    }
  } catch (e) {
    // print('Error saving QR code: $e');
    Get.snackbar(
      'Error',
      'Failed to save QR code: ${e.toString()}',
      snackPosition: SnackPosition.TOP,
    );
  }
}