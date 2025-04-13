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

  void onDetectQrCode(BarcodeCapture barcode) {
    final List<Barcode> barcodes = barcode.barcodes;
    for (var element in barcodes) {
      if (element.rawValue != null) {
        print('scanned qr code ${element.rawValue}');
      }
    }
  }
}
