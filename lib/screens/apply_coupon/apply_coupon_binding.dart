part of 'apply_coupon_view.dart';

class ApplyCouponViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApplyCouponViewController());
  }
}
