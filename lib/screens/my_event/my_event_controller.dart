part of 'my_event_view.dart';

class MyEventViewController extends GetxController {
  var myEvent = <dynamic>[].obs;
  @override
  void onInit() {
    super.onInit();
    loadHostedEvent();
  }

  void loadHostedEvent() async {
    const storage = FlutterSecureStorage();
    var id = await storage.read(key: 'id');
    var token = await storage.read(key: 'token');
    if (token == null || id == null) {
      Get.find<AuthService>().logout();
      return;
    }
    try {
      EventApiHelper.setToken(token);
      var response = await EventApiHelper.get('/users/$id/events');
      print('my booked event response ${response.data}');
      print('my booked event statuscode ${response.statusCode}');
      if (response.statusCode == 200) {
        myEvent.value = response.data['data'];
        print('my booked event my event $myEvent');
      }
    } on DioException catch (e) {
      print(e.response?.data);
    }
  }
}
