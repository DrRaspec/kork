part of 'your_ticket_view.dart';

class YourTicketViewController extends GetxController {
  var argument = Get.arguments as Event;
  var checkoutController = Get.find<CheckoutController>();
  final _currentIndex = 0.obs;
  late final List<String> imageList;
  var quantity = 0;
  var buyedTickets = <dynamic>[].obs;
  final GlobalKey qrKey = GlobalKey();

  @override
  void onInit() {
    super.onInit();
    print(checkoutController.ticketQuantity.length);
    for (var element in checkoutController.ticketQuantity) {
      quantity += element;
    }
    imageList = List.generate(
      quantity,
      (index) {
        return argument.posterUrl;
      },
    );
    fetchBookedEvent();
  }

  void seeAllBookedEvent() {
    var mainIndex = Get.find<MainController>().currentIndex;
    mainIndex.value = 2;
    Get.offAllNamed(Routes.main);
  }

  void fetchBookedEvent() async {
    const storage = FlutterSecureStorage();
    var token = await storage.read(key: 'token');
    var id = await storage.read(key: 'id');
    if (token == null || id == null) await Get.find<AuthService>().logout();
    try {
      var params = {'per_page': 3};
      var response =
          await EventApiHelper.get('/users/$id/buy-tickets', params: params);
      var result = response.data;
      print('your ticket response $result');
      if (response.statusCode == 200 && result.containsKey("data")) {
        buyedTickets.value = result['data'];
      }
    } on DioException catch (e) {
      if (e.response != null) {
        var response = e.response;
        print('error status code: ${response!.statusCode}');
        print('error status message: ${response.statusMessage}');
        print('error: ${e.error}');
        print('message: ${e.message}');
      }
    }
  }

  // Future<void> getGenerateQrCode(BuildContext context) async {
  //   // Check if there are any bought tickets first
  //   if (buyedTickets.isEmpty) {
  //     Get.snackbar(
  //       'Error',
  //       'No tickets available to download',
  //       snackPosition: SnackPosition.BOTTOM,
  //     );
  //     return;
  //   }
  //
  //   var ticket = BoughtTicket.fromJson(buyedTickets[0]);
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
  //                             position:
  //                                 PrettyQrDecorationImagePosition.embedded,
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
  //                     argument.eventName,
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
  //   await _saveQrCode(tempQrKey, ticket);
  // }

  // Future<void> _saveQrCode(GlobalKey key, BoughtTicket ticket) async {
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
  //         key.currentContext!.findRenderObject() as RenderRepaintBoundary;
  //
  //     // Generate image with higher quality
  //     ui.Image image = await boundary.toImage(pixelRatio: 3.0);
  //     ByteData? byteData =
  //         await image.toByteData(format: ui.ImageByteFormat.png);
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
  //       print('File saved result: $result');
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
  //     print('Error saving QR code: $e');
  //     Get.snackbar(
  //       'Error',
  //       'Failed to save QR code: ${e.toString()}',
  //       snackPosition: SnackPosition.TOP,
  //     );
  //   }
  // }
}
