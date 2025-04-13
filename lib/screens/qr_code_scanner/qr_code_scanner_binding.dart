part of 'qr_code_scanner_view.dart';

class QrCodeScannerViewBinding extends Bindings {

   @override
   void dependencies() {
       Get.lazyPut(() => QrCodeScannerViewController());
   }
}