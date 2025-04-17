import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kork/helper/save_qr_code.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

import '../models/event_model.dart';

Future<void> getGenerateQrCode(
  BuildContext context,
  List boughtTickets,
  String eventName,
) async {
  // Check if there are any bought tickets first
  if (boughtTickets.isEmpty) {
    Get.snackbar(
      'Error',
      'No tickets available to download',
      snackPosition: SnackPosition.BOTTOM,
    );
    return;
  }

  var ticket = BoughtTicket.fromJson(boughtTickets[0]);
  // print('ticket text ${ticket.ticketCode}');

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

                // PrettyQrView implementation
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
                            data: ticket.ticketCode,
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
  await saveQrCode(tempQrKey, ticket);
}
