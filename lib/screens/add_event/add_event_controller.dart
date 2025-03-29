part of 'add_event_view.dart';

class AddEventViewController extends GetxController {
  // Ticket Type and Ticket Types
  List<String> ticketTypes = ["1 Type", "2 Types", "3 Types", "4 Types"].obs;
  List<String> types = ["Standard", "Normal", "VIP", "VVIP"].obs;

  // Ticket Controllers
  var ticketController = <TextEditingController>[].obs;
  var ticketPriceController = <TextEditingController>[].obs;
  var ticketQuantityController = <TextEditingController>[].obs;
  var selectedValue = Rx<String?>("4 Type");

  // Image Picker
  final ImagePicker _picker = ImagePicker();
  var selectedImage = Rx<File?>(null);

  // Event Details Controllers
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

  // Payment Details Controllers
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
  var address = '';

  var cardType = 'Visa'.obs;
  Timer? _debounceTimer;

  @override
  void onInit() {
    super.onInit();
    updateControllers(selectedValue.value);

    // Initialize Focus Nodes for Payment Details
    cardNumberFocus = FocusNode();
    cardHolderFocus = FocusNode();
    ccvFocus = FocusNode();
    expireDateFocus = FocusNode();
  }

  @override
  void onClose() {
    // Dispose of all controllers and focus nodes
    nameController.dispose();
    focusName.dispose();

    locationController.dispose();
    focusLocation.dispose();

    categoryController.dispose();
    focusCategory.dispose();

    startDateController.dispose();
    focusStartDate.dispose();

    endDateController.dispose();
    focusEndDate.dispose();

    startTimeController.dispose();
    focusStartTime.dispose();

    endTimeController.dispose();
    focusEndTime.dispose();

    descriptionController.dispose();
    focusDescription.dispose();

    companyNameController.dispose();
    focusCompanyName.dispose();

    // Dispose of ticket controllers
    for (var controller in ticketController) {
      controller.dispose();
    }
    ticketController.clear();

    for (var controller in ticketPriceController) {
      controller.dispose();
    }
    ticketPriceController.clear();

    for (var controller in ticketQuantityController) {
      controller.dispose();
    }
    ticketQuantityController.clear();

    // Dispose of payment-related controllers
    cardNumberController.dispose();
    cardNumberFocus.dispose();

    cardHolderController.dispose();
    cardHolderFocus.dispose();

    ccvController.dispose();
    ccvFocus.dispose();

    expireDateController.dispose();
    expireDateFocus.dispose();

    _debounceTimer?.cancel();

    super.onClose();
  }

  void updateControllers(String? value) {
    int count = int.tryParse(value?.split(" ")[0] ?? "0") ?? 0;

    // Dispose of existing controllers
    for (var controller in ticketController) {
      controller.dispose();
    }
    ticketController.clear();

    for (var controller in ticketPriceController) {
      controller.dispose();
    }
    ticketPriceController.clear();

    // Clear and dispose quantity controllers
    for (var controller in ticketQuantityController) {
      controller.dispose();
    }
    ticketQuantityController.clear();

    // Create new controllers based on selected ticket type count
    for (int i = 0; i < count; i++) {
      ticketController.add(TextEditingController());
      ticketPriceController.add(TextEditingController());
      ticketQuantityController.add(TextEditingController());
    }
  }

  void getLocation() async {
    await Get.toNamed(Routes.mapView, arguments: 'back');
    locationController.text = Get.find<MapController>().address.value;
    address =
        '${Get.find<MapController>().selectedLocation.value.latitude}, ${Get.find<MapController>().selectedLocation.value.longitude}';
  }

  void getDate({bool isStartDate = true}) async {
    DateTime? date = await showDatePicker(
      context: Get.context!,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 365 * 2),
      ),
    );
    if (date != null) {
      final formattedDate = DateFormat('yyyy-MM-dd').format(date);

      if (isStartDate) {
        startDateController.text = formattedDate;
        if (endDateController.text.isNotEmpty) {
          try {
            final endDate =
                DateFormat('yyyy-MM-dd').parse(endDateController.text);
            if (endDate.isBefore(date)) {
              endDateController.text = '';
            }
          } catch (e) {
            endDateController.text = '';
          }
        }
      } else {
        if (startDateController.text.isNotEmpty) {
          try {
            final startDate =
                DateFormat('yyyy-MM-dd').parse(startDateController.text);
            if (date.isAfter(startDate)) {
              endDateController.text = formattedDate;
            } else {
              Get.snackbar(
                'Error',
                'End date must be after start date',
                snackPosition: SnackPosition.TOP,
              );
            }
          } catch (e) {
            endDateController.text = formattedDate;
          }
        } else {
          endDateController.text = formattedDate;
        }
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
      int hour24 = (time.period == DayPeriod.pm && time.hour != 12)
          ? time.hour + 12
          : (time.period == DayPeriod.am && time.hour == 12)
              ? 0
              : time.hour;

      String formattedTime =
          '${hour24.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';

      if (isStartTime) {
        startTimeController.text = formattedTime;
      } else {
        endTimeController.text = formattedTime;
      }
    }
  }

  bool checkValidation() {
    bool hasError = false;

    // Reset all error values
    nameError.value = '';
    locationError.value = '';
    categoryError.value = '';
    startDateError.value = '';
    endDateError.value = '';
    startTimeError.value = '';
    endTimeError.value = '';
    descriptionError.value = '';
    cardNumberError.value = false;
    cardHolderError.value = false;
    ccvError.value = false;
    expireDateError.value = false;

    // Validate Name
    if (nameController.text.trim().isEmpty) {
      nameError.value =
          '${AppLocalizations.of(Get.context!)!.name} ${AppLocalizations.of(Get.context!)!.cant_empty}';
      hasError = true;
    }

    // Validate Location
    if (locationController.text.trim().isEmpty) {
      locationError.value =
          '${AppLocalizations.of(Get.context!)!.location} ${AppLocalizations.of(Get.context!)!.cant_empty}';
      hasError = true;
    }

    // Validate Category
    if (categoryController.text.trim().isEmpty) {
      categoryError.value =
          '${AppLocalizations.of(Get.context!)!.category} ${AppLocalizations.of(Get.context!)!.cant_empty}';
      hasError = true;
    }

    // Validate Start Date
    if (startDateController.text.trim().isEmpty) {
      startDateError.value =
          '${AppLocalizations.of(Get.context!)!.start_date} ${AppLocalizations.of(Get.context!)!.cant_empty}';
      hasError = true;
    }

    // Validate End Date
    if (endDateController.text.trim().isEmpty) {
      endDateError.value =
          '${AppLocalizations.of(Get.context!)!.end_date} ${AppLocalizations.of(Get.context!)!.cant_empty}';
      hasError = true;
    }

    // Validate Start Time
    if (startTimeController.text.trim().isEmpty) {
      startTimeError.value =
          '${AppLocalizations.of(Get.context!)!.start_time} ${AppLocalizations.of(Get.context!)!.cant_empty}';
      hasError = true;
    }

    // Validate End Time
    if (endTimeController.text.trim().isEmpty) {
      endTimeError.value =
          '${AppLocalizations.of(Get.context!)!.end_time} ${AppLocalizations.of(Get.context!)!.cant_empty}';
      hasError = true;
    }

    // Validate Description
    if (descriptionController.text.trim().isEmpty) {
      descriptionError.value =
          '${AppLocalizations.of(Get.context!)!.description} ${AppLocalizations.of(Get.context!)!.cant_empty}';
      hasError = true;
    }

    // Validate Ticket Types, Prices, and Quantities
    int ticketCount =
        int.tryParse(selectedValue.value?.split(" ")[0] ?? "0") ?? 0;

    for (int i = 0; i < ticketCount; i++) {
      // Validate ticket type
      if (ticketController[i].text.trim().isEmpty) {
        ticketController[i].text = '${types[i]} Ticket';
      }

      // Validate ticket price
      if (ticketPriceController[i].text.trim().isEmpty) {
        ticketPriceController[i].text = '0';
        hasError = true;
      } else {
        // Ensure price is a valid number
        if (double.tryParse(ticketPriceController[i].text) == null) {
          ticketPriceController[i].text = '0';
          hasError = true;
        }
      }

      // Validate ticket quantity
      if (ticketQuantityController[i].text.trim().isEmpty) {
        ticketQuantityController[i].text = '0';
        hasError = true;
      } else {
        // Ensure quantity is a valid integer
        if (int.tryParse(ticketQuantityController[i].text) == null) {
          ticketQuantityController[i].text = '0';
          hasError = true;
        }
      }
    }

    // Validate Poster
    if (selectedImage.value == null) {
      hasError = true;
      Get.snackbar(
        'Error',
        'Event poster is required',
        snackPosition: SnackPosition.TOP,
      );
    }

    // Validate Card Number
    cardType.value = getCardType(cardNumberController.text.trim());
    if (cardNumberController.text.trim().isEmpty) {
      cardNumberError.value = true;
      hasError = true;
    } else if (RegExp(r'^[0-9]+$').hasMatch(cardNumberController.text) ||
        cardType.value == 'Unknown') {
      cardNumberError.value = true;
      hasError = true;
    }

    // Validate Card Holder
    if (cardHolderController.text.isEmpty) {
      cardHolderError.value = true;
      hasError = true;
    } else if (RegExp(r'^[a-zA-Z]+$').hasMatch(cardHolderController.text)) {
      cardHolderError.value = true;
      hasError = true;
    }

    // Validate CCV
    if (ccvController.text.trim().isEmpty) {
      ccvError.value = true;
      hasError = true;
    }

    // Validate Expire Date
    if (expireDateController.text.trim().isEmpty) {
      expireDateError.value = true;
      hasError = true;
    } else if (RegExp(r'^[0-9]+$').hasMatch(expireDateController.text)) {
      expireDateError.value = true;
      hasError = true;
    }

    // Handle focus for first error field
    if (hasError) {
      Future.delayed(Duration.zero, () {
        // Focus handling for various fields
        if (nameError.isNotEmpty) {
          focusName.requestFocus();
        } else if (locationError.isNotEmpty) {
          focusLocation.requestFocus();
        } else if (categoryError.isNotEmpty) {
          focusCategory.requestFocus();
        } else if (startDateError.isNotEmpty) {
          focusStartDate.requestFocus();
        } else if (endDateError.isNotEmpty) {
          focusEndDate.requestFocus();
        } else if (startTimeError.isNotEmpty) {
          focusStartTime.requestFocus();
        } else if (endTimeError.isNotEmpty) {
          focusEndTime.requestFocus();
        } else if (descriptionError.isNotEmpty) {
          focusDescription.requestFocus();
        } else if (cardNumberError.value) {
          cardNumberFocus.requestFocus();
        } else if (cardHolderError.value) {
          cardHolderFocus.requestFocus();
        } else if (ccvError.value) {
          ccvFocus.requestFocus();
        } else if (expireDateError.value) {
          expireDateFocus.requestFocus();
        } else {
          for (int i = 0; i < ticketCount; i++) {
            if (ticketPriceController[i].text == '0') {
              ticketPriceController[i].selection = TextSelection.fromPosition(
                  TextPosition(offset: ticketPriceController[i].text.length));
              break;
            }
          }
        }
      });

      cardType.value = 'Visa';
    }
    return !hasError;
  }

  void onSubmit() async {
    if (checkValidation()) {
      try {
        var formData = FormData.fromMap({
          'event_name': nameController.text,
          'event_type': categoryController.text.toLowerCase(),
          'description': descriptionController.text,
          'location': address,
          'poster_url': selectedImage.value != null
              ? await MultipartFile.fromFile(
                  selectedImage.value!.path,
                  filename:
                      'event_poster.${selectedImage.value!.path.split('.').last}',
                )
              : null,
          'start_date': startDateController.text,
          'end_date': endDateController.text,
          'start_time': startTimeController.text,
          'end_time': endTimeController.text,
        });

        int ticketCount =
            int.tryParse(selectedValue.value?.split(" ")[0] ?? "0") ?? 0;

        for (int i = 0; i < ticketCount; i++) {
          formData.fields.add(MapEntry(
              'tickets[$i][ticket_type]', types[i].toString().toLowerCase()));
          formData.fields.add(
              MapEntry('tickets[$i][price]', ticketPriceController[i].text));
          formData.fields.add(
              MapEntry('tickets[$i][qty]', ticketQuantityController[i].text));
        }

        const storage = FlutterSecureStorage();
        var token = await storage.read(key: 'token') ?? 'error';
        EventApiHelper.setToken(token);
        var response = await EventApiHelper.post('/events', data: formData);

        print('Response Status Code: ${response.statusCode}');
        print('Response Data: ${response.data['errors']}');

        if (response.statusCode == 201 || response.statusCode == 200) {
          Get.snackbar(
            'Success',
            'Event created successfully',
            snackPosition: SnackPosition.TOP,
            duration: const Duration(milliseconds: 350),
          );
        }
      } on DioException catch (e) {
        print('Dio Error: ${e.response?.data['errors']}');
        print('Error Message: ${e.message}');
        print('Status Code: ${e.response?.statusCode}');

        Get.snackbar(
          'Error',
          e.response?.data['message'] ?? 'Failed to create event',
          snackPosition: SnackPosition.TOP,
        );
      } catch (e) {
        print('Unexpected Error: $e');
        Get.snackbar(
          'Error',
          'An unexpected error occurred',
          snackPosition: SnackPosition.TOP,
        );
      }
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

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImage.value = File(image.path);
    }
  }

  String getCardType(String cardNumber) {
    if (cardNumber.startsWith('4')) return 'Visa';
    if (cardNumber.startsWith('5')) return 'MasterCard';
    return 'Unknown';
  }
}
