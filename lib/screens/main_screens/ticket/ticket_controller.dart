part of 'ticket_view.dart';

class TicketController extends GetxController {
  final dio = Dio();
  final storage = const FlutterSecureStorage();
  late String url;

  var buyedTickets = <dynamic>[].obs;

  @override
  void onInit() {
    super.onInit();
    url = dotenv.maybeGet('API_URL') ?? 'Not Found';
    init();
  }

  void init() async {
    var token = await storage.read(key: 'token');
    var id = await storage.read(key: 'id');
    if (token == null || id == null) await Get.find<AuthService>().logout();
    try {
      dio.interceptors.add(AppLogInterceptor());
      dio.options.baseUrl = url;
      dio.options.headers = {
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': 'Bearer $token',
      };
      dio.options.connectTimeout = const Duration(seconds: 15);
      dio.options.receiveTimeout = const Duration(seconds: 15);

      var response = await dio.get('/users/$id/buy-tickets');
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
