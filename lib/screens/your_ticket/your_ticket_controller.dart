part of 'your_ticket_view.dart';

class YourTicketViewController extends GetxController {
  var argument = Get.arguments as List;
  var checkoutController = Get.find<CheckoutController>();
  final _currentIndex = 0.obs;
  final imageList = <String>[].obs;
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
    imageList.value = List.generate(
      quantity,
          (index) {
        var boughtEvent = BoughtTicket.fromJson(argument[index]);
        return boughtEvent.event.posterUrl;
      },
    );
    fetchBookedEvent();
  }

  // Future<void> askPermission() async {
  //   if (await Permission.storage
  //       .request()
  //       .isDenied || await Permission.storage
  //       .request()
  //       .isPermanentlyDenied) {
  //       await Permission.storage.request();
  //   }
  //
  //   // For Android 13+
  //   if(await Permission.photos.request().isDenied || await Permission.photos.request().isPermanentlyDenied) {
  //     await Permission.photos.request();
  //   }
  // }

  void seeAllBookedEvent() {
    var mainIndex = Get
        .find<MainController>()
        .currentIndex;
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
        var data = response?.data['data'] as Map;
        print('error status code: ${response!.statusCode}');
        print('error status message: ${response.statusMessage}');
        var errorMessage = data.containsKey('error') ? data['error']
            : 'Unable to fetch data';
        Get.snackbar('Error', errorMessage);
        // print('error: ${e.error}');
        // print('message: ${e.message}');
      }
    }
  }
}
