part of 'search_event.dart';

class SearchEventController extends GetxController {
  var searchEvent = TextEditingController();
  var recentSearch = <String>[].obs;
  final int maxRecentSearch = 5;

  @override
  void onInit() {
    super.onInit();
    loadRecentSearch();
  }

  @override
  void onClose() {
    searchEvent.dispose();
    super.onClose();
  }

  void loadRecentSearch() {
    try{
      final savedSearches = GetStorage().read<List>('recent_event_searches');
      if (savedSearches != null) {
        recentSearch.value = savedSearches.map((e) => e.toString()).toList();
      }
    } catch (e) {
      print('Error loading recent searches: $e');
    }
  }

  void saveSearch(String searchItem) {
    if (searchItem
        .trim()
        .isEmpty) {
      return;
    }
    recentSearch.remove(searchItem);
    recentSearch.insert(0, searchItem);
    if (recentSearch.length > maxRecentSearch) {
      recentSearch.value = recentSearch.sublist(0, maxRecentSearch);
    }

    saveRecentSearchesToStorage();
  }

  void saveRecentSearchesToStorage() {
    try {
      GetStorage().write('recent_event_searches', recentSearch.toList());
    } catch (e) {
      print('Error saving recent searches: $e');
    }
  }

  void removeRecentSearch(String searchItem) {
    recentSearch.remove(searchItem);
    saveRecentSearchesToStorage();
  }

  void onSubmit(String value) {
    saveSearch(value);
    Get.toNamed(Routes.searchResult, arguments: value);
    // if (Get.arguments is bool && Get.arguments == true) {
    //   Get.offNamed(Routes.searchResult, arguments: value);
    // } else {
    //   Get.toNamed(Routes.searchResult, arguments: value);
    // }
  }

  void onRecentTap(String search) {
    Get.toNamed(Routes.searchResult, arguments: search);
    // if (Get.arguments is bool && Get.arguments == true) {
    //   Get.offNamed(Routes.searchResult, arguments: search);
    // } else {
    //   Get.toNamed(Routes.searchResult, arguments: search);
    // }
  }
}
