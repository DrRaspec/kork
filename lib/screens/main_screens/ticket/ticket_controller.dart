part of 'ticket_view.dart';

class TicketController extends GetxController {
  final dio = Dio();
  final storage = const FlutterSecureStorage();
  late String url;
  String? token;
  String? id;

  var buyedTickets = <dynamic>[].obs;
  var lastEvent = <dynamic>[].obs;

  // For pagination
  final int perPage = 15;
  var currentPage = 1;
  var isLoading = false.obs;
  var hasMoreData = true.obs;
  final ScrollController scrollController = ScrollController();

  var isSelectionMode = false.obs;
  var selectedTickets = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    url = dotenv.maybeGet('API_URL') ?? 'Not Found';
    init();
    fetchLastData();

    // Add scroll listener
    scrollController.addListener(_scrollListener);
  }

  @override
  void onClose() {
    scrollController.removeListener(_scrollListener);
    scrollController.dispose();
    super.onClose();
  }

  void _scrollListener() {
    if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent * 0.8 &&
        !isLoading.value &&
        hasMoreData.value) {
      loadMoreTickets();
    }
  }

  void loadMoreTickets() async {
    if (isLoading.value || !hasMoreData.value) return;

    isLoading.value = true;
    currentPage++;

    try {
      const storage = FlutterSecureStorage();
      var token = await storage.read(key: 'token');
      if (token == null || token.isEmpty) {
        Get.find<AuthService>().logout;
        return;
      }

      dio.options.headers = {
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': 'Bearer $token',
      };

      var response = await dio.get('/users/$id/buy-tickets', queryParameters: {
        'page': currentPage,
        'per_page': perPage,
      });

      var result = response.data as Map<String, dynamic>;
      if (response.statusCode == 200 && result.containsKey("data")) {
        var newData = result['data'] as List;
        if (newData.isEmpty) {
          hasMoreData.value = false;
        } else {
          buyedTickets.addAll(newData);
        }
        print('all showing tickets ${buyedTickets.length}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        var response = e.response;
        print('error status code: ${response!.statusCode}');
        print('error status message: ${response.statusMessage}');
        print('error: ${e.error}');
        print('message: ${e.message}');
      }
    } finally {
      isLoading.value = false;
    }
  }

  void init() async {
    token = await storage.read(key: 'token');
    id = await storage.read(key: 'id');
    if (token == null || id == null) {
      await Get.find<AuthService>().logout();
      return;
    }

    EventApiHelper.setToken(token!);
    try {
      const storage = FlutterSecureStorage();
      var token = await storage.read(key: 'token');
      if (token == null || token.isEmpty) {
        Get.find<AuthService>().logout;
        return;
      }
      EventApiHelper.setToken(token);
      dio.interceptors.add(AppLogInterceptor());
      dio.options.baseUrl = url;
      dio.options.headers = {
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': 'Bearer $token',
      };
      dio.options.connectTimeout = const Duration(minutes: 1);
      dio.options.receiveTimeout = const Duration(minutes: 1);

      // Update to use per_page parameter
      var response = await dio.get('/users/$id/buy-tickets', queryParameters: {
        'page': 1,
        'per_page': perPage,
      });

      var result = response.data as Map<String, dynamic>;
      if (response.statusCode == 200 && result.containsKey("data")) {
        print('buyed ticket ${result['data']}');
        buyedTickets.value = result['data'];

        // Reset pagination state on initial load
        currentPage = 1;
        hasMoreData.value = result['data'].length >= perPage;
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

  void fetchLastData() async {
    var params = {'date': 'today', 'per_page': 5};
    try {
      var response = await EventApiHelper.get('/events', params: params);
      print('response ticket data ${response.data}');
      if (response.statusCode == 200 && response.data != null) {
        lastEvent.assignAll(response.data['data']);
      }
    } on DioException catch (e) {
      var response = e.response;
      print('error status code: ${response!.statusCode}');
      print('error status message: ${response.statusMessage}');
      print('error: ${e.error}');
      print('message: ${e.message}');
    }
  }

  void refreshData() {
    currentPage = 1;
    hasMoreData.value = true;
    buyedTickets.clear();
    init();
    fetchLastData();
  }

  void startSelection() {
    isSelectionMode.value = true;
  }

  bool isTicketSelection(String ticketCode) {
    return selectedTickets.contains(ticketCode);
  }

  void toggleTicketSelection(String ticketCode) {
    if (selectedTickets.contains(ticketCode)) {
      selectedTickets.remove(ticketCode);

      if (selectedTickets.isEmpty) {
        isSelectionMode.value = false;
        // selectedTickets.add(ticketCode);
      }
    } else {
      selectedTickets.add(ticketCode);
    }
  }

  void clearSelection() {
    selectedTickets.clear();
    isSelectionMode.value = false;
  }

  void genQrCode(BuildContext context) {
    var selectedBoughtTicket = buyedTickets.where(
      (item) {
        var ticket = BoughtTicket.fromJson(item);
        return selectedTickets.contains(ticket.ticketCode);
      },
    ).toList();
    generateTicketListQrCode(
      context: context,
      boughtTickets: selectedBoughtTicket,
      justView: true,
    );
  }
}
