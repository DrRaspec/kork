part of 'qr_code_scanner_view.dart';

class QrCodeScannerViewController extends GetxController {
  Rx<String> languageCode =
      Get.find<LanguageController>().currentLocale.languageCode.obs;
  var isFlashOn = false.obs;
  late MobileScannerController scannerController;
  var isProcessing = false.obs;
  Rect? scanArea;
  final scanAreaSize = 250.0;

  @override
  void onInit() {
    super.onInit();
    scannerController = MobileScannerController();
  }

  void toggleFlash() {
    isFlashOn.value = !isFlashOn.value;
    scannerController.toggleTorch();
  }

  @override
  void onClose() {
    scannerController.dispose();
    super.onClose();
  }

  void onDetectQrCode(BarcodeCapture barcode) async {
    if (isProcessing.value) {
      return;
    }

    if (scanArea == null) {
      final screenWidth = Get.width;
      final screenHeight = Get.height;
      final centerX = screenWidth / 2;
      final centerY = screenHeight / 2;

      scanArea = Rect.fromCenter(
        center: Offset(centerX, centerY),
        width: scanAreaSize,
        height: scanAreaSize,
      );
    }

    final barcodes = barcode.barcodes;
    for (var element in barcodes) {
      if (element.corners.isNotEmpty) {
        bool isWithinScanArea = false;
        for (var corner in element.corners) {
          // Fix: Use the correct properties from the corner object
          // The MobileScanner corners are likely Point objects with x and y properties
          if (scanArea!.contains(Offset(corner.dx, corner.dy))) {
            isWithinScanArea = true;
            break;
          }
        }

        if (!isWithinScanArea) continue;
      }

      if (element.rawValue != null) {
        isProcessing.value = true;

        try {
          const storage = FlutterSecureStorage();
          var token = await storage.read(key: 'token');
          var id = await storage.read(key: 'id');
          if (token == null || id == null) {
            Get.find<AuthService>().logout();
            return;
          }
          print('scanned qr code ${element.rawValue}');

          List data = [];
          try {
            var tempData = jsonDecode(element.rawValue!);
            if (tempData is List) {
              data = tempData;
            } else if (tempData is String && tempData.isNotEmpty) {
              data.add(tempData);
            } else {
              data.add(tempData.toString());
            }
            print('decode data $data');
          } catch (jsonError) {
            if (element.rawValue != null && element.rawValue!.isNotEmpty) {
              data.add(element.rawValue!);
              print('Using plain text as ticket ID: $data');
            } else {
              scanError('Invalid QR code format');
              return;
            }
          }

          var formData = {
            "_method": "DELETE",
            "tickets": data,
          };

          var response = await EventApiHelper.post(
            '/users/$id/scan-tickets',
            data: formData,
          );

          if (response.statusCode == 200 || response.statusCode == 201) {
            String message = response.data['success'];
            scanSuccess(message);
            Get.snackbar('Successful', 'Scan Successful');
          }
        } on DioException catch (e) {
          var response = e.response;
          String errorMessage = 'Scan Failed';

          if (e.type == DioExceptionType.connectionTimeout ||
              e.type == DioExceptionType.receiveTimeout ||
              e.type == DioExceptionType.sendTimeout) {
            errorMessage = 'Connection timeout. Please try again.';
          } else if (e.type == DioExceptionType.connectionError) {
            errorMessage = 'No internet connection. Please check your network.';
          } else if (e.response != null) {
            if (e.response!.statusCode == 401) {
              errorMessage = 'Authentication failed. Please login again.';
              Get.find<AuthService>().logout();
            } else if (e.response!.statusCode == 403) {
              errorMessage = 'You do not have permission to scan this ticket.';
            } else if (e.response!.statusCode == 404) {
              errorMessage = 'Invalid ticket or already scanned.';
            } else if (e.response!.data != null &&
                e.response!.data['error'] != null) {
              errorMessage = e.response!.data['error'];
            }
          }

          scanError(errorMessage);
          print('QR Scan error: ${e.toString()}');
        } catch (generalError) {
          scanError('Unexpected error occurred');
          print('General error during scan: ${generalError.toString()}');
        }
        break;
      }
    }
  }

  void resetScannerAndAllowScanning() {
    isProcessing.value = false;
  }

  void scanSuccess(String message) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Get.theme.colorScheme.secondary,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            Positioned(
              top: 16,
              left: 16,
              right: 16,
              child: Center(
                child: Lottie.asset(
                  'assets/animation/scan_successful.json',
                  width: 65,
                  height: 65,
                  fit: BoxFit.cover,
                  repeat: false,
                ),
              ),
            ),
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Column(
                children: [
                  Text(
                    message,
                    style: TextStyle(
                      fontSize: 16,
                      color: Get.theme.colorScheme.tertiary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 34),
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                        Future.delayed(const Duration(seconds: 1), () {
                          resetScannerAndAllowScanning();
                        });
                      },
                      child: buttonDesign(text: "OK", height: 28),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }

  void scanError(String message) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Get.theme.colorScheme.secondary,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            Positioned(
              top: 16,
              left: 16,
              right: 16,
              child: Center(
                child: Lottie.asset(
                  'assets/animation/scan_fail.json',
                  width: 65,
                  height: 65,
                  fit: BoxFit.cover,
                  repeat: false,
                ),
              ),
            ),
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Column(
                children: [
                  Text(
                    message,
                    style: TextStyle(
                      fontSize: 16,
                      color: Get.theme.colorScheme.tertiary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 34),
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                        Future.delayed(const Duration(seconds: 1), () {
                          resetScannerAndAllowScanning();
                        });
                      },
                      child: buttonDesign(text: "OK", height: 28),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }
}
