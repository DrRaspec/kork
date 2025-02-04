part of '../views/event_view.dart';

class EventController extends GetxController {
  var isEvent = true.obs;
  final translator = GoogleTranslator();
  var translatedDate = 'Apr'.obs;
  var languageController = Get.find<LanguageController>();

  @override
  void onInit() {
    super.onInit();

    if (!languageController.isEnglish.value) {
      translated();
    }
  }

  void translated() async {
    final translator = GoogleTranslator();
    var translation = await translator.translate('Apr', to: 'km');
    translatedDate.value = translation.text;
  }
}
