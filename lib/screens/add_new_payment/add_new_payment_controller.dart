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

  // var isSuccess = false;
  var result = <String, dynamic>{};

  var status = Status.success.obs;

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

  bool checkValidation() {
    bool hasError = false;
    cardNumberError.value = false;
    cardHolderError.value = false;
    expireDateError.value = false;
    ccvError.value = false;
    cardType.value = getCardType(cardNumberController.text.trim());
    if (cardNumberController.text.trim().isEmpty) {
      cardNumberError.value = true;
      hasError = true;
    } else if (!RegExp(r'^[0-9]+$').hasMatch(cardNumberController.text) ||
        cardType.value == 'Unknown') {
      cardNumberError.value = true;
      hasError = true;
    }

    if (cardHolderController.text.isEmpty) {
      cardHolderError.value = true;
      hasError = true;
    } else if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(cardHolderController.text)) {
      cardHolderError.value = true;
      hasError = true;
    }

    if (expireDateController.text.trim().isEmpty) {
      expireDateError.value = true;
      hasError = true;
    } else if (!RegExp(r'^[0-9]{2}/[0-9]{2}$')
        .hasMatch(expireDateController.text)) {
      expireDateError.value = true;
      hasError = true;
    } else {
      try {
        final parts = expireDateController.text.split('/');
        int month = int.parse(parts[0]);
        int year = int.parse('20${parts[1]}');

        final expirationDate = DateTime(year, month + 1, 0);
        final currentDate = DateTime.now();

        if (currentDate.isAfter(expirationDate)) {
          expireDateError.value = true;
          hasError = true;
        }
      } catch (e) {
        expireDateError.value = true;
        hasError = true;
      }
    }

    if (hasError) {
      Future.delayed(Duration.zero, () {
        if (cardNumberError.value == true) {
          cardNumberFocus.requestFocus();
        } else if (cardHolderError.value == true) {
          cardHolderFocus.requestFocus();
        } else if (expireDateError.value == true) {
          expireDateFocus.requestFocus();
        } else if (ccvError.value == true) {
          ccvFocus.requestFocus();
        }
      });
      cardType.value = 'Visa';
    }
    return !hasError;
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

  void addCard() async {
    if (checkValidation()) {
      const storage = FlutterSecureStorage();
      status.value = Status.loading;
      var token = await storage.read(key: 'token');
      var id = await storage.read(key: 'id');
      if (token == null || id == null) {
        await Get.find<AuthService>().logout();
        return;
      }
      final cvv = ccvController.text.trim();
      final validCvv = cvv.length > 3 ? cvv.substring(0, 3) : cvv;
      var formData = FormData.fromMap({
        'card_number': cardNumberController.text,
        'card_holder_name': cardHolderController.text,
        'expired_date': expireDateController.text,
        'cvv': validCvv,
      });
      try {
        EventApiHelper.setToken(token);
        var response = await EventApiHelper.post('/users/$id/payment-methods',
            data: formData);
        if (response.statusCode == 201) {
          status.value = Status.success;
          Get.snackbar(
            'Success',
            'Add Successful',
          );
          result = response.data;
        }
      } on DioException catch (e) {
        status.value = Status.error;
        var response = e.response;
        var data = response?.data as Map<String, dynamic>;
        print('e error ${e.error}');
        print('response error $data');
        print('response status code ${response?.statusCode}');
        Get.snackbar(
          'Fail',
          data.containsKey('error') ? data['error'] : 'Add fail',
        );
      }
    }
  }
}
