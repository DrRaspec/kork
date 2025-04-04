import 'package:flutter/material.dart';
import 'package:kork/models/event_model.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

void generateQrCode(
    BuildContext context, BoughtTicket ticket, String eventName) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        contentPadding: EdgeInsets.zero,
        content: SizedBox(
          width: 350,
          height: 450,
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

              // Corrected PrettyQrView implementation
              Positioned(
                top: 140,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: SizedBox(
                    width: 224, // Set width explicitly
                    height: 224, // Set height explicitly
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

              // Scan instruction
              Positioned(
                top: 95,
                child: Text(
                  "Scan here to verify your ticket",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[700],
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
      );
    },
  );
}
