import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart'; // Add this import
import 'package:kork/helper/event_api_helper.dart';
import 'package:kork/screens/search_event/search_event.dart';
import 'package:kork/utils/status.dart';

class SearchResultController extends GetxController {
  var argument = Get.arguments as String;
  var searchController = TextEditingController();
  var page = 1.obs;
  var perPage = 15;
  var status = Status.loading.obs;
  var searchResult = [].obs;
  var isLastPage = false.obs;
  var isLoading = false.obs;
  var scrollController = ScrollController();
  var recentSearch = <String>[].obs; // Add this
  final int maxRecentSearch = 5; // Add this

  @override
  void onInit() {
    searchController.text = argument;
    scrollController.addListener(_scrollListener);
    loadRecentSearch(); // Add this
    saveSearch(argument); // Add this to save the initial search
    searchEvent(isLoadMore: false);
    super.onInit();
  }

  @override
  void dispose() {
    searchController.dispose();
    scrollController.removeListener(_scrollListener);
    scrollController.dispose();
    super.dispose();
  }

  void loadRecentSearch() {
    try {
      final savedSearches = GetStorage().read<List>('recent_event_searches');
      if (savedSearches != null) {
        recentSearch.value = savedSearches.map((e) => e.toString()).toList();
      }
    } catch (e) {
      print('Error loading recent searches: $e');
    }
  }

  void saveSearch(String searchItem) {
    if (searchItem.trim().isEmpty) {
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

  void _scrollListener() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200) {
      if (!isLastPage.value &&
          !isLoading.value &&
          status.value != Status.loadingMore) {
        loadMore();
      }
    }
  }

  void loadMore() {
    if (!isLoading.value) {
      page.value++;
      searchEvent(isLoadMore: true);
    }
  }

  void resetSearch({bool clearSearchText = false}) {
    if (clearSearchText) {
      searchController.text = '';
      page.value = 1;
      isLastPage.value = false;
      searchResult.clear();
      status.value = Status.noData;
    } else {
      page.value = 1;
      isLastPage.value = false;
      searchResult.clear();
      searchEvent(isLoadMore: false);
    }
  }

  void searchEvent({required bool isLoadMore}) async {
    try {
      if (isLoading.value) return;

      if (!isLoadMore) {
        saveSearch(searchController.text);
      }

      isLoading.value = true;
      status.value = isLoadMore ? Status.loadingMore : Status.loading;

      var param = {
        'search': searchController.text,
        'page': page.value,
        'per_page': perPage,
      };
      var response = await EventApiHelper.get(
        '/events',
        params: param,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        var newData = response.data['data'] as List;

        if (newData.isEmpty || newData.length < perPage) {
          isLastPage.value = true;
        }

        if (isLoadMore) {
          searchResult.addAll(newData);
        } else {
          searchResult.value = newData;
        }

        if (searchResult.isEmpty) {
          status.value = Status.noData;
        } else {
          status.value = Status.success;
        }
      } else {
        status.value = Status.error;
      }
    } on DioException catch (e) {
      status.value = Status.error;

      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        Get.snackbar(
          'Connection Timeout',
          'Please check your internet connection and try again.',
        );
      } else {
        var response = e.response;
        var data = response?.data as Map;
        var errorMessage =
        data.containsKey('error') ? data['error'] : 'Unable to load data';
        Get.snackbar('Error', errorMessage);
      }

      if (isLoadMore) {
        page.value--;
      }
    } catch (e) {
      status.value = Status.error;
      Get.snackbar('Error', 'An unexpected error occurred');

      if (isLoadMore) {
        page.value--;
      }
    } finally {
      isLoading.value = false;
    }
  }

  void onBack() {
    Get.find<SearchEventController>().loadRecentSearch();
    Get.back();
  }
}