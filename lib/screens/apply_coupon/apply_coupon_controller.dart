part of 'apply_coupon_view.dart';

class ApplyCouponViewController extends GetxController {
  var searchCouponController = TextEditingController();
  var searchText = ''.obs;
  var coupons = <Map<String, dynamic>>[
    {'coupon': 'ANT!', 'discount': 20},
    {'coupon': '168OK', 'discount': 10},
  ].obs;
  final focusNode = FocusNode();
  // final isValidCoupon = false.obs;
  var validCoupon = <String, dynamic>{}.obs;

  @override
  void onInit() {
    super.onInit();
    focusNode.addListener(_onFocusChange);
  }

  @override
  void onClose() {
    focusNode.removeListener(_onFocusChange);
    focusNode.dispose();
    searchCouponController.dispose();
    super.onClose();
  }

  void _onFocusChange() {
    if (!focusNode.hasFocus) {
      if (searchCouponController.text.isNotEmpty) {
        validateCoupon();
      }
    }
  }

  void validateCoupon() {
    // isValidCoupon.value =
    //     coupon.contains(searchCouponController.text); //get value as bool

    validCoupon.value = coupons.firstWhere(
      (element) => element['coupon'] == searchCouponController.text,
      orElse: () => {},
    );
    // try {
    //   validCoupon.value = coupons.firstWhere(
    //     (element) => element['coupon'] == searchCouponController.text,
    //     orElse: () => {},
    //   );
    // } catch (e) {
    //   validCoupon.value = {};
    // }
    // if (!isValidCoupon.value) {
    //   print('Invalid coupon: ${searchCouponController.text}');
    // }
  }
}
