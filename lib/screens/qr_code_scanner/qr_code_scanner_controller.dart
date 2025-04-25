part of 'qr_code_scanner_view.dart';

class QrCodeScannerViewController extends GetxController {
  Rx<String> languageCode =
      Get.find<LanguageController>().currentLocale.languageCode.obs;
  var isFlashOn = false.obs;
  final scannerController = MobileScannerController();

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
    final barcodes = barcode.barcodes;
    for (var element in barcodes) {
      if (element.rawValue != null) {
        try {
          const storage = FlutterSecureStorage();
          var token = await storage.read(key: 'token');
          var id = await storage.read(key: 'id');
          if (token == null || id == null) {
            Get.find<AuthService>().logout();
            return;
          }
          print('scanned qr code ${element.rawValue}');
          var data = jsonDecode(element.rawValue!) as List;
          print('decode data $data');
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
          var data = response?.data;
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

            showErrorSnackBar(errorMessage);

            print('QR Scan error: ${e.toString()}');
          }
        }
        // var eventName
        // var response = await EventApiHelper.post('/users/2/scan-tickets');
      }
    }
  }

  void scanSuccess(String message) {
    Get.showOverlay(
      asyncFunction: () async {
        await Future.delayed(
          const Duration(milliseconds: 800),
        );
        return;
      },
      loadingWidget: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
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
                child: Container(
                  color: Colors.black54,
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
                      child: buttonDesign(text: "OK", height: 24),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      opacity: 0.8,
    );
  }

  void scanError(String message) {
    Get.showOverlay(
      asyncFunction: () async {
        await Future.delayed(
          const Duration(milliseconds: 800),
        );
        return;
      },
      loadingWidget: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
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
                child: Container(
                  color: Colors.black54,
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
                      child: buttonDesign(text: "OK", height: 24),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      opacity: 0.8,
    );
  }
}
