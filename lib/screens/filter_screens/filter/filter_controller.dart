part of 'filter_view.dart';

class FilterController extends GetxController {
  var selectCategory = 0.obs;
  var selectDate = ''.obs;

  var pickedDate = Rxn<DateTime>();

  var currentRange = const RangeValues(80, 120).obs;
  final double minPrice = 0;
  final double maxPrice = 200;

  var filterItem = <String, dynamic>{}.obs;

  var selectedLocation = ''.obs;

  void updateSelectCategory(int index) {
    selectCategory.value = index;
  }

  void updateSelectDate(String value) {
    selectDate.value = value;
  }

  void navigateToFilterLocation() async {
    var result = await Get.toNamed(Routes.filterLocation);
    if (result is String) {
      selectedLocation.value = result;
    }
  }
}
