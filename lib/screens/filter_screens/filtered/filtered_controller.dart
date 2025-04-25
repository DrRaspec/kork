part of 'filtered_view.dart';

class FilteredController extends GetxController
    with GetSingleTickerProviderStateMixin {
  var argument = Get.arguments as Map<String, dynamic>;
  var status = Status.none.obs;
  var currentIndex = (-1).obs;
  var events = [].obs;

  var isExpanded = false.obs;
  late AnimationController animationController;

  @override
  void onInit() {
    animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    fetchData();
    super.onInit();
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }

  void toggleExpansion() {
    isExpanded.value = !isExpanded.value;
    if (isExpanded.value) {
      animationController.forward();
    } else {
      animationController.reverse();
    }
  }

  void fetchData({String filter = ''}) async {
    const storage = FlutterSecureStorage();
    status.value = Status.loading;
    var token = await storage.read(key: 'token');

    if (token == null) {
      await Get.find<AuthService>().logout();
      return;
    }

    try {
      var params = '';
      if (filter.isEmpty) {
        if (argument.containsKey('filter')) {
          params += 'filter=${argument['filter']},';
        }
        if (argument.containsKey('min_price')) {
          params += 'min_price=${argument['min_price']},';
        }
        if (argument.containsKey('max_price')) {
          params += 'max_price=${argument['max_price']},';
        }
        if (argument.containsKey('date')) {
          params += 'date=${argument['date']},';
        }

        if (params.endsWith(',')) {
          params = params.substring(0, params.length - 1);
        }
      } else {
        params = '$filter=${argument[filter]}';
      }

      var response = await EventApiHelper.get('/events', params: argument);
      print('response data ${response.data}');
      if (response.statusCode == 200) {
        status.value = Status.success;
        events.value = response.data['data'];
      } else {
        status.value = Status.error;
      }
    } on DioException catch (e) {
      var data = e.response?.data;
      status.value = Status.error;
      var errorMessage = 'not found';
      if (data is Map) {
        errorMessage = data.containsKey('error')
            ? data['error']
            : data.containsKey('result')
                ? data['result']
                : data;
      }
      showErrorSnackBar(errorMessage);
    }
  }
}
