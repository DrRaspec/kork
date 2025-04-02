part of 'bookmark_view.dart';

class BookmarkViewController extends GetxController {
  var bookmarks = <dynamic>[].obs;
  var status = Status.noData.obs;
  var page = 1;
  final scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    fetchBookmark();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent &&
          status.value != Status.loadingMore &&
          status.value != Status.noData) {
        fetchMoreData();
      }
    });
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  void fetchBookmark() async {
    if (status.value == Status.loadingMore || status.value == Status.loading) {
      return;
    }

    if (page == 1) {
      status.value = Status.loading;
    } else {
      status.value = Status.loadingMore;
    }

    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');
    final id = await storage.read(key: 'id');
    if (token == null) {
      Get.find<AuthService>().logout();
      return;
    }
    BookmarkHelper.setToken(token);
    try {
      var response = await BookmarkHelper.get('/users/$id/bookmarks');
      if (response.statusCode == 200) {
        List<dynamic> result = response.data['data'];

        if (result.isEmpty && page == 1) {
          status.value = Status.noData;
        } else {
          bookmarks.addAll(result);
          status.value = Status.success;

          if (result.length < 15) {
            status.value = Status.noData;
          }
        }
      } else {
        status.value = Status.error;
        print("Error: ${response.statusCode} - ${response.data}");
      }
    } on DioException catch (e) {
      status.value = Status.error;
      var response = e.response;
      print('e message ${e.message}');
      print('e error ${e.error}');
      print('status code ${response?.statusCode}');
      print('data ${response?.data}');
    }
  }

  Future<void> fetchMoreData() async {
    if (status.value == Status.noData || status.value == Status.loading) return;

    status.value = Status.loadingMore;
    page++;
    fetchBookmark();
  }
}
