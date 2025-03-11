part of 'add_new_payment_view.dart';

class AddNewPaymentViewController extends GetxController
    with GetTickerProviderStateMixin {
  var cardType = 'Visa'.obs;
  Timer? _debounceTimer;

  var cardNumberController = TextEditingController();
  var cardNumberError = false.obs;
  late FocusNode cardNumberFocus;

  var cardHolderController = TextEditingController();
  var cardHolderError = false.obs;
  late FocusNode cardHolderFocus;

  var ccvController = TextEditingController();
  var ccvError = false.obs;
  late FocusNode ccvFocus;

  var expireDateController = TextEditingController();
  var expireDateError = false.obs;
  late FocusNode expireDateFocus;

  @override
  void onInit() {
    super.onInit();
    cardNumberFocus = FocusNode();
    cardHolderFocus = FocusNode();
    ccvFocus = FocusNode();
    expireDateFocus = FocusNode();
  }

  @override
  void onClose() {
    super.onClose();
    cardNumberController.dispose();
    cardNumberFocus.dispose();

    cardHolderController.dispose();
    cardHolderFocus.dispose();

    ccvController.dispose();
    ccvFocus.dispose();

    expireDateController.dispose();
    expireDateFocus.dispose();

    _debounceTimer?.cancel();
  }

  void checkValidation() {
    bool hasError = false;
    cardNumberError.value = false;
    cardType.value = getCardType(cardNumberController.text.trim());
    if (cardNumberController.text.trim().isEmpty) {
      cardNumberError.value = true;
      hasError = true;
    } else if (RegExp(r'^[0-9]+$').hasMatch(cardNumberController.text) ||
        cardType.value == 'Unknown') {
      cardNumberError.value = true;
      hasError = true;
    }

    if (cardHolderController.text.isEmpty) {
      cardHolderError.value = true;
      hasError = true;
    } else if (RegExp(r'^[a-zA-Z]+$').hasMatch(cardHolderController.text)) {
      cardHolderError.value = true;
      hasError = true;
    }

    if (expireDateController.text.trim().isEmpty) {
      expireDateError.value = true;
      hasError = true;
    } else if (RegExp(r'^[0-9]+$').hasMatch(expireDateController.text)) {
      expireDateError.value = true;
      hasError = true;
    }

    if (hasError) {
      Future.delayed(Duration.zero, () {
        if (cardNumberError.value == true) {
          cardNumberFocus.requestFocus();
        } else if (cardNumberError.value == false &&
            cardHolderError.value == true) {
          cardNumberFocus.requestFocus();
        }
      });
      cardType.value = 'Visa';
    }
  }

  void onCardNumberChange() {
    if (_debounceTimer?.isActive ?? false) _debounceTimer?.cancel();

    _debounceTimer = Timer(
      const Duration(milliseconds: 300),
      () {
        cardType.value = getCardType(cardNumberController.text.trim());
      },
    );
  }

  void onExpireDateChange() {
    if (_debounceTimer?.isActive ?? false) _debounceTimer?.cancel();

    _debounceTimer = Timer(
      const Duration(milliseconds: 300),
      () {
        var formatedDate = formatDate(expireDateController.text);
        expireDateController.text = formatedDate;
      },
    );
  }

  String formatDate(String input) {
    input = input.replaceAll(RegExp(r'\D'), '');
    if (input.length > 4) {
      input = input.substring(0, 4);
    }

    String month = input.substring(0, 2);
    String year = input.substring(2, 4);

    return "$month/$year";
  }
}
