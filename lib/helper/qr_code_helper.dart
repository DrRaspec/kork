import 'dart:async';
import 'dart:convert';
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
import 'package:pretty_qr_code/pretty_qr_code.dart';

// Future<void> getGenerateQrCode(
//     BuildContext context,
//     List boughtTickets,
//     String eventName,
//     ) async {
//   // Check if there are any bought tickets first
//   if (boughtTickets.isEmpty) {
//     Get.snackbar(
//       'Error',
//       'No tickets available to download',
//       snackPosition: SnackPosition.BOTTOM,
//     );
//     return;
//   }
//
//   var ticket = BoughtTicket.fromJson(boughtTickets[0]);
//   // print('ticket text ${ticket.ticketCode}');
//
//   final completer = Completer<void>();
//   final tempQrKey = GlobalKey();
//   showDialog(
//     context: context,
//     builder: (BuildContext dialogContext) {
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         completer.complete();
//       });
//
//       return AlertDialog(
//         contentPadding: EdgeInsets.zero,
//         content: SizedBox(
//           width: 350,
//           height: 450,
//           child: RepaintBoundary(
//             key: tempQrKey,
//             child: Stack(
//               alignment: Alignment.center,
//               children: [
//                 // Background template
//                 Container(
//                   width: 350,
//                   height: 450,
//                   clipBehavior: Clip.hardEdge,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Image.asset(
//                     'assets/image/QR_templete.png',
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//
//                 // PrettyQrView implementation
//                 Positioned(
//                   top: 140,
//                   child: Container(
//                     padding: const EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: SizedBox(
//                       width: 224,
//                       height: 224,
//                       child: PrettyQrView(
//                         qrImage: QrImage(
//                           QrCode.fromData(
//                             data: ticket.ticketCode,
//                             errorCorrectLevel: QrErrorCorrectLevel.H,
//                           ),
//                         ),
//                         decoration: const PrettyQrDecoration(
//                           shape: PrettyQrSmoothSymbol(
//                             color: Colors.black,
//                           ),
//                           image: PrettyQrDecorationImage(
//                             image: AssetImage('assets/image/light-logo.png'),
//                             position: PrettyQrDecorationImagePosition.embedded,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//
//                 // Event name
//                 Positioned(
//                   top: 380,
//                   child: Text(
//                     eventName,
//                     style: const TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                       color: Color(0xff404144),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     },
//   );
//
//   // Wait for dialog to be fully rendered
//   await completer.future;
//
//   // Add a longer delay to ensure everything is properly rendered
//   await Future.delayed(const Duration(seconds: 1));
//
//   // Save the QR code
//   await saveQrCode(tempQrKey, ticket);
// }
//
//
// Future<void> saveQrCode(GlobalKey key, BoughtTicket ticket) async {
//   try {
//     // Check storage permission
//     var status = await Permission.storage.status;
//     if (!status.isGranted) {
//       await Permission.storage.request();
//       status = await Permission.storage.status;
//       if (!status.isGranted) {
//         Get.snackbar(
//           'Permission Denied',
//           'Storage permission is required to save QR code',
//           snackPosition: SnackPosition.TOP,
//         );
//         return;
//       }
//     }
//
//     // Validate context
//     if (key.currentContext == null) {
//       Get.snackbar(
//         'Error',
//         'QR code is not ready yet. Please try again.',
//         snackPosition: SnackPosition.TOP,
//       );
//       return;
//     }
//
//     // Render QR code
//     RenderRepaintBoundary boundary =
//     key.currentContext!.findRenderObject() as RenderRepaintBoundary;
//
//     // Generate image with higher quality
//     ui.Image image = await boundary.toImage(pixelRatio: 3.0);
//     ByteData? byteData =
//     await image.toByteData(format: ui.ImageByteFormat.png);
//
//     if (byteData != null) {
//       Uint8List pngBytes = byteData.buffer.asUint8List();
//
//       // Get temporary directory
//       final tempDir = await getTemporaryDirectory();
//       final file = File('${tempDir.path}/QR_${ticket.event.eventName}.png');
//
//       // Write to temporary file
//       await file.writeAsBytes(pngBytes);
//
//       // Use file_saver directly with the file path
//       final result = await FileSaver.instance.saveAs(
//         name: "QR_${ticket.event.eventName}",
//         ext: "png",
//         filePath: file.path,
//         mimeType: MimeType.png,
//       );
//
//       // print('File saved result: $result');
//
//       Get.snackbar(
//         'Success',
//         'QR code saved! Check your Downloads folder.',
//         snackPosition: SnackPosition.TOP,
//         duration: const Duration(seconds: 3),
//       );
//     } else {
//       throw Exception('Failed to generate image data');
//     }
//   } catch (e) {
//     // print('Error saving QR code: $e');
//     Get.snackbar(
//       'Error',
//       'Failed to save QR code: ${e.toString()}',
//       snackPosition: SnackPosition.TOP,
//     );
//   }
// }

Future<void> generateTicketListQrCode(
    BuildContext context,
    List boughtTickets,
    // String eventName,
    // String eventId, // Added event ID parameter
    ) async {
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

  // Extract all ticket codes into a list
  List<String> ticketCodes = [];
  for (var ticketData in boughtTickets) {
    var ticket = BoughtTicket.fromJson(ticketData);
    ticketCodes.add(ticket.ticketCode);
    print('Ticket code: ${ticket.ticketCode}');
  }

  // Create a map with event ID and ticket codes
  // final Map<String, dynamic> qrData = {
  //   'eventId': eventId,
  //   'tickets': ticketCodes,
  // };

  // Convert to JSON string
  // final jsonData = jsonEncode(qrData);

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

  // Wait for dialog to be fully rendered
  await completer.future;

  // Add a longer delay to ensure everything is properly rendered
  await Future.delayed(const Duration(seconds: 1));

  // Save the QR code
  await saveTicketListQrCode(tempQrKey, eventName, ticketCodes.length);
}

Future<void> saveTicketListQrCode(GlobalKey key, String eventName, int ticketCount) async {
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
      final file = File('${tempDir.path}/QR_${eventName}_${ticketCount}Tickets.png');

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