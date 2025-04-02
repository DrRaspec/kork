part of 'your_ticket_view.dart';

class YourTicketViewController extends GetxController {
  var argument = Get.arguments as Event;
  var checkoutController = Get.find<CheckoutController>();
  final _currentIndex = 0.obs;
  late final List<String> imageList;
  var quantity = 0;
  var buyedTickets = <dynamic>[].obs;

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
      var result = response.data as Map<String, dynamic>;
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
}
