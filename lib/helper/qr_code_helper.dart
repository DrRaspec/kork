import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kork/helper/show_error_snack_bar.dart';
import 'package:kork/models/event_model.dart';
import 'package:media_scanner/media_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_saver/file_saver.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:screenshot/screenshot.dart';

Future<void> generateTicketListQrCode({
  required BuildContext context,
  required List boughtTickets,
  bool justView = false,
}) async {
  var eventName = BoughtTicket.fromJson(boughtTickets[0]).event.eventName;
  // var eventId = BoughtTicket.fromJson(boughtTickets[0]).eventId;
  if (boughtTickets.isEmpty) {
    Get.snackbar(
      'Error',
      'No tickets available to download',
      snackPosition: SnackPosition.BOTTOM,
    );
    return;
  }

  List<String> ticketCodes = [];
  for (var ticketData in boughtTickets) {
    var ticket = BoughtTicket.fromJson(ticketData);
    ticketCodes.add(ticket.ticketCode);
    print('Ticket code: ${ticket.ticketCode}');
  }

  final jsonData = jsonEncode(ticketCodes);

  final completer = Completer<void>();
  final tempQrKey = GlobalKey();
  showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        completer.complete();
      });

      return AlertDialog(
        contentPadding: EdgeInsets.zero,
        content: SizedBox(
          width: 350,
          height: 450,
          child: RepaintBoundary(
            key: tempQrKey,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Background template
                Container(
                  width: 350,
                  height: 450,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Image.asset(
                    'assets/image/QR_templete.png',
                    fit: BoxFit.cover,
                  ),
                ),

                // PrettyQrView implementation with event ID and ticket codes
                Positioned(
                  top: 140,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: SizedBox(
                      width: 224,
                      height: 224,
                      child: PrettyQrView(
                        qrImage: QrImage(
                          QrCode.fromData(
                            data: jsonData, // Contains eventId and ticket codes
                            errorCorrectLevel: QrErrorCorrectLevel.H,
                          ),
                        ),
                        decoration: const PrettyQrDecoration(
                          shape: PrettyQrSmoothSymbol(
                            color: Colors.black,
                          ),
                          image: PrettyQrDecorationImage(
                            image: AssetImage('assets/image/light-logo.png'),
                            position: PrettyQrDecorationImagePosition.embedded,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // Event name
                Positioned(
                  top: 380,
                  child: Text(
                    eventName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff404144),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );

  if (!justView) {
    // Wait for dialog to be fully rendered
    await completer.future;

    // Add a longer delay to ensure everything is properly rendered
    await Future.delayed(const Duration(seconds: 1));

    // Save the QR code
    await saveTicketListQrCode(tempQrKey, eventName, ticketCodes.length);
  }
}

Future<void> generateQrCode({
  required BuildContext context,
  required BoughtTicket boughtTickets,
}) async {
  // var event = BoughtTicket.fromJson(boughtTickets[0]);
  // var eventId = BoughtTicket.fromJson(boughtTickets[0]).eventId;
  // if (boughtTickets.isEmpty) {
  //   Get.snackbar(
  //     'Error',
  //     'No tickets available to download',
  //     snackPosition: SnackPosition.BOTTOM,
  //   );
  //   return;
  // }

  // List<String> ticketCodes = [];
  // for (var ticketData in boughtTickets) {
  //   var ticket = BoughtTicket.fromJson(ticketData);
  //   ticketCodes.add(ticket.ticketCode);
  //   print('Ticket code: ${ticket.ticketCode}');
  // }

  final jsonData = jsonEncode(boughtTickets.ticketCode);

  final completer = Completer<void>();
  final tempQrKey = GlobalKey();
  showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        completer.complete();
      });

      return AlertDialog(
        contentPadding: EdgeInsets.zero,
        content: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 380, maxHeight: 450),
          child: RepaintBoundary(
            key: tempQrKey,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Background template
                Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Get.theme.colorScheme.secondary,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        const SizedBox(height: 16),
                        Text(
                          boughtTickets.event.eventName,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Get.theme.colorScheme.tertiary,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          boughtTickets.event.description,
                          style: TextStyle(
                            fontSize: 12,
                            color: Get.theme.colorScheme.surfaceTint,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),

                // PrettyQrView implementation with event ID and ticket codes
                Positioned(
                  top: 130,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: SizedBox(
                      width: 224,
                      height: 224,
                      child: PrettyQrView(
                        qrImage: QrImage(
                          QrCode.fromData(
                            data: jsonData, // Contains eventId and ticket codes
                            errorCorrectLevel: QrErrorCorrectLevel.H,
                          ),
                        ),
                        decoration: const PrettyQrDecoration(
                          shape: PrettyQrSmoothSymbol(
                            color: Colors.black,
                          ),
                          image: PrettyQrDecorationImage(
                            image: AssetImage('assets/image/light-logo.png'),
                            position: PrettyQrDecorationImagePosition.embedded,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                Positioned(
                  bottom: 16,
                  // left: 16,
                  child: Row(
                    spacing: Get.width * 0.05,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => saveTicketListQrCode(
                          tempQrKey,
                          boughtTickets.event.eventName,
                          1,
                        ),
                        child: Container(
                          width: 125,
                          height: 28,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: Get.theme.colorScheme.primary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            spacing: 8,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/image/svg/download.svg',
                                width: 16,
                                height: 16,
                                colorFilter: const ColorFilter.mode(
                                  Color(0xffEAE9FC),
                                  BlendMode.srcIn,
                                ),
                              ),
                              Container(
                                width: 1,
                                height: 11,
                                color: const Color(0xffEAE9FC),
                              ),
                              Expanded(
                                child: Text(
                                  AppLocalizations.of(context)!.download,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Color(0xffEAE9FC),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => takeScreenshot(),
                        child: Container(
                          width: 125,
                          height: 28,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: Get.theme.colorScheme.primary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            spacing: 8,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/image/svg/camera.svg',
                                width: 16,
                                height: 16,
                                colorFilter: const ColorFilter.mode(
                                  Color(0xffEAE9FC),
                                  BlendMode.srcIn,
                                ),
                              ),
                              Container(
                                width: 1,
                                height: 11,
                                color: const Color(0xffEAE9FC),
                              ),
                              Expanded(
                                child: Text(
                                  AppLocalizations.of(context)!.screenshot,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Color(0xffEAE9FC),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Future<void> saveTicketListQrCode(
    GlobalKey key, String eventName, int ticketCount) async {
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
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

    if (byteData != null) {
      Uint8List pngBytes = byteData.buffer.asUint8List();

      // Get temporary directory
      final tempDir = await getTemporaryDirectory();
      final file =
          File('${tempDir.path}/QR_${eventName}_${ticketCount}Tickets.png');

      // Write to temporary file
      await file.writeAsBytes(pngBytes);

      // Use file_saver directly with the file path
      await FileSaver.instance.saveAs(
        name: "QR_${eventName}_${ticketCount}Tickets",
        ext: "png",
        filePath: file.path,
        mimeType: MimeType.png,
      );

      Get.snackbar(
        'Success',
        'QR code with ${ticketCount} tickets saved! Check your Downloads folder.',
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
      );
    } else {
      throw Exception('Failed to generate image data');
    }
  } catch (e) {
    Get.snackbar(
      'Error',
      'Failed to save QR code: ${e.toString()}',
      snackPosition: SnackPosition.TOP,
    );
  }
}

Future<void> takeScreenshot() async {
  final screenshot = ScreenshotController();
  // Request storage permission
  final status = await Permission.storage.request();
  if (!status.isGranted) {
    Get.snackbar(
      'Permission Denied',
      'Storage permission is required to save screenshots',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.withOpacity(0.8),
      colorText: Colors.white,
    );
    return;
  }

  try {
    // Capture the screenshot as bytes
    final Uint8List? imageBytes = await screenshot.capture();

    if (imageBytes != null) {
      // Get the timestamp for unique filename
      final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      final String fileName = 'screenshot_$timestamp.png';

      // Save the file
      if (Platform.isAndroid || Platform.isIOS) {
        // For mobile platforms
        final String? filePath = await FileSaver.instance.saveAs(
          name: fileName,
          bytes: imageBytes,
          ext: 'png',
          mimeType: MimeType.png,
        );

        if (filePath != null) {
          // Scan the file so it shows up in gallery
          await MediaScanner.loadMedia(path: filePath);
          Get.snackbar('Success', 'Screenshot saved to gallery');
        } else {
          showErrorSnackBar('Failed to save screenshot');
        }
      } else {
        // For other platforms (desktop)
        final directory = await getApplicationDocumentsDirectory();
        final File file = File('${directory.path}/$fileName');
        await file.writeAsBytes(imageBytes);
        Get.snackbar('Success', 'Screenshot saved to ${file.path}');
      }
    } else {
      showErrorSnackBar('Failed to capture screenshot');
    }
  } catch (e) {
    showErrorSnackBar('Error taking screenshot: $e');
  }
}
