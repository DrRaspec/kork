part of 'add_event_view.dart';

class AddEventViewController extends GetxController {
  // var ticketType = 4.obs;
  List<String> ticketTypes = ["1 Type", "2 Types", "3 Types", "4 Types"].obs;
  List<String> types = ["Standard", "Normal", "VIP", "VVIP"].obs;
  var ticketController = <TextEditingController>[].obs;
  var ticketPriceController = <TextEditingController>[].obs;
  var selectedValue = Rx<String?>("4 Type");
  final ImagePicker _picker = ImagePicker();
  var selectedImage = Rx<File?>(null);

  var nameController = TextEditingController();
  var focusName = FocusNode();
  var nameError = ''.obs;

  var locationController = TextEditingController();
  var focusLocation = FocusNode();
  var locationError = ''.obs;

  var categoryController = TextEditingController();
  var focusCategory = FocusNode();
  var categoryError = ''.obs;

  var startDateController = TextEditingController();
  var focusStartDate = FocusNode();
  var startDateError = ''.obs;

  var endDateController = TextEditingController();
  var focusEndDate = FocusNode();
  var endDateError = ''.obs;

  var startTimeController = TextEditingController();
  var focusStartTime = FocusNode();
  var startTimeError = ''.obs;

  var endTimeController = TextEditingController();
  var focusEndTime = FocusNode();
  var endTimeError = ''.obs;

  var descriptionController = TextEditingController();
  var focusDescription = FocusNode();
  var descriptionError = ''.obs;

  var companyNameController = TextEditingController();
  var focusCompanyName = FocusNode();
  var companyNameError = ''.obs;

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

  var cardType = 'Visa'.obs;
  Timer? _debounceTimer;

  @override
  void onInit() {
    super.onInit();
    updateControllers(selectedValue.value);
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

  void updateControllers(String? value) {
    int count = int.tryParse(value?.split(" ")[0] ?? "0") ?? 0;

    for (var controller in ticketController) {
      controller.dispose();
    }
    ticketController.clear();
    for (var controller in ticketPriceController) {
      controller.dispose();
    }
    ticketPriceController.clear();

    for (int i = 0; i < count; i++) {
      ticketController.add(TextEditingController());
      ticketPriceController.add(TextEditingController());
    }
  }

  void validateInput() {
    nameError.value = '';
    var hasError = false;
    if (nameController.text.trim().isEmpty) {
      nameError.value =
          '${AppLocalizations.of(Get.context!)!.name} ${AppLocalizations.of(Get.context!)!.cant_empty}';
      hasError = true;
    }

    if (hasError) {
      focusName.requestFocus();
    }
  }

  void getLocation() async {
    await Get.toNamed(Routes.mapView);
    locationController.text = Get.find<MapController>().address.value;
    // print('Getted location $location');
  }

  void getDate({bool isStartDate = true}) async {
    DateTime? date = await showDatePicker(
      context: Get.context!,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(
          days: 365 * 2,
        ),
      ),
    );
    if (date != null) {
      if (isStartDate) {
        startDateController.text = DateFormat('dd/MM/yyyy').format(date);
      } else {
        endDateController.text = DateFormat('dd/MM/yyyy').format(date);
      }
    }
  }

  void getTime({bool isStartTime = true}) async {
    TimeOfDay? time = await showTimePicker(
      context: Get.context!,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );
    if (time != null) {
      String period = time.period == DayPeriod.am ? "AM" : "PM";
      int hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
      var formattedTime =
          '${hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')} $period';
      if (isStartTime) {
        startTimeController.text = formattedTime;
      } else {
        endTimeController.text = formattedTime;
      }
    }
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

  Future<void> pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      selectedImage.value = File(image.path);
    }
  }
}
