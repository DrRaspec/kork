part of 'filter_view.dart';

class FilterController extends GetxController {
  var selectCategory = (-1).obs;
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
    // filterItem['max_price'] = currentRange.value.end;
    super.onInit();
  }

  void updateSelectCategory(int index, {String? categoryName}) {
    if (selectCategory.value == index) {
      selectCategory.value = -1;
      if (filterItem.containsKey('filter')) {
        filterItem.remove('filter');
      }
    } else {
      selectCategory.value = index;
      if (categoryName != null) {
        filterItem['filter'] = categoryName.toLowerCase();
      }
    }
  }

  void updateSelectDate(String value) {
    if (selectDate.value == value) {
      selectDate.value = '';
      if (filterItem.containsKey('date')) {
        filterItem.remove('date');
      }
    } else {
      selectDate.value = value;
      filterItem['date'] = value;
    }
  }

  void navigateToFilterLocation() async {
    var result = await Get.toNamed(Routes.filterLocation);
    if (result is String) {
      selectedLocation.value = result;
    }
  }
}
