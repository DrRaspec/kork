part of 'filter_view.dart';

class FilterController extends GetxController {
  var selectCategory = 0.obs;
  var selectDate = ''.obs;

  var pickedDate = Rxn<DateTime>();

  var currentRange = const RangeValues(20, 30).obs;
  final double minPrice = 0;
  final double maxPrice = 50;

  var filterItem = <String, dynamic>{}.obs;

  var selectedLocation = ''.obs;

  @override
  void onInit() {
    filterItem['min_price'] = currentRange.value.start;
    filterItem['max_price'] = currentRange.value.end;
    super.onInit();
  }

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
