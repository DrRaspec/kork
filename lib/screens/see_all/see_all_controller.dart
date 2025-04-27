part of 'see_all_view.dart';

class SeeAllViewController extends GetxController {
  var argument = Get.arguments as String;
  late String title;
  var page = 1.obs;
  var status = Status.none.obs;
  var eventData = <Map<String, dynamic>>[].obs;
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    title = argument;

    fetchData();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent &&
          status.value != Status.loadingMore &&
          status.value != Status.noData) {
        loadMoreData();
      }
    });
  }

  Future<void> fetchData() async {
    if (status.value == Status.loading || status.value == Status.loadingMore) {
      return;
    }

    status.value = Status.loading;
    try {
      var params = {
        // 'filter': title,
        title != 'today' ? 'filter' : 'date': title.toLowerCase(),
        'page': page.value,
      };
      var response = await EventApiHelper.get('/events', params: params);

      if (response.statusCode == 200 && response.data['data'] != null) {
        List<Map<String, dynamic>> newData =
            List<Map<String, dynamic>>.from(response.data['data']);

        if (newData.isEmpty && page.value == 1) {
          status.value = Status.noData;
        } else {
          eventData.addAll(newData);
          status.value = Status.success;

          if (newData.length < 15) {
            status.value = Status.noData;
          }
        }
      } else {
        status.value = Status.error;
        print("Error: ${response.statusCode} - ${response.data}");
      }
    } on DioException catch (e) {
      status.value = Status.error;
      print('Error message: ${e.message}');
      print('Error status code: ${e.response?.statusCode}');
    }
  }

  Future<void> loadMoreData() async {
    if (status.value == Status.noData || status.value == Status.loadingMore) {
      return;
    }

    status.value = Status.loadingMore;
    page.value++;
    await fetchData();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
