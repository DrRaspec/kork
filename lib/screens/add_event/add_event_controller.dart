part of 'add_event_view.dart';

class AddEventViewController extends GetxController {
  List<String> ticketTypes = ["1 Type", "2 Types", "3 Types", "4 Types"].obs;
  List<String> types = ["Standard", "Normal", "VIP", "VVIP"].obs;

  var ticketController = <TextEditingController>[].obs;
  var ticketPriceController = <TextEditingController>[].obs;
  var ticketQuantityController = <TextEditingController>[].obs;
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
  var address = '';

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
    categoryController.text = AppLocalizations.of(Get.context!)!.sport.firstCapitalize();
  }

  @override
  void onClose() {
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
              endDateController.text = formattedDate;
            }
          } catch (e) {
            endDateController.text = formattedDate;
          }
        }
      } else {
        if (startDateController.text.isNotEmpty) {
          try {
            final startDate =
                DateFormat('yyyy-MM-dd').parse(startDateController.text);

            if (!date.isBefore(startDate)) {
              endDateController.text = formattedDate;

              if (date.isAtSameMomentAs(startDate) &&
                  startTimeController.text.isNotEmpty &&
                  endTimeController.text.isNotEmpty) {
                final startTimeParts = startTimeController.text.split(':');
                final endTimeParts = endTimeController.text.split(':');

                if (startTimeParts.length == 2 && endTimeParts.length == 2) {
                  final startHour = int.tryParse(startTimeParts[0]) ?? 0;
                  final startMinute = int.tryParse(startTimeParts[1]) ?? 0;
                  final endHour = int.tryParse(endTimeParts[0]) ?? 0;
                  final endMinute = int.tryParse(endTimeParts[1]) ?? 0;

                  if (endHour < startHour ||
                      (endHour == startHour && endMinute <= startMinute)) {
                    endTimeController.text = '';
                    Get.snackbar(
                      'Time Error',
                      'End time must be after start time when dates are the same',
                      snackPosition: SnackPosition.TOP,
                    );
                  }
                }
              }
            } else {
              Get.snackbar(
                'Error',
                'End date cannot be before start date',
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
      int hour24 = (time.hour % 12) + (time.period == DayPeriod.pm ? 12 : 0);
      String formattedTime =
          '$hour24:${time.minute.toString().padLeft(2, '0')}';

      if (isStartTime) {
        startTimeController.text = formattedTime;
      } else {
        endTimeController.text = formattedTime;
      }

      if (startDateController.text.isNotEmpty &&
          endDateController.text.isNotEmpty) {
        DateTime startDate = DateTime.parse(startDateController.text);
        DateTime endDate = DateTime.parse(endDateController.text);

        Duration difference = endDate.difference(startDate);

        if (difference.inDays > 30) {
          Get.snackbar(
            'Date Error',
            'The end date cannot be more than 30 days after the start date',
            snackPosition: SnackPosition.TOP,
          );
          endDateController.text = '';
          return;
        }

        if (difference.inDays == 0 &&
            startTimeController.text.isNotEmpty &&
            endTimeController.text.isNotEmpty) {
          final startTimeParts = startTimeController.text.split(':');
          final endTimeParts = endTimeController.text.split(':');

          final startHour = int.parse(startTimeParts[0]);
          final startMinute = int.parse(startTimeParts[1]);
          final endHour = int.parse(endTimeParts[0]);
          final endMinute = int.parse(endTimeParts[1]);

          if (endHour < startHour ||
              (endHour == startHour && endMinute <= startMinute)) {
            endTimeController.text = '';
            Get.snackbar(
              'Time Error',
              'End time must be after start time when the dates are the same',
              snackPosition: SnackPosition.TOP,
            );
          }
        }
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
      showErrorSnackBar(nameError.value);
      focusName.requestFocus();
      return false;
    }

    // Validate Location
    if (locationController.text.trim().isEmpty) {
      locationError.value =
      '${AppLocalizations.of(Get.context!)!.location} ${AppLocalizations.of(Get.context!)!.cant_empty}';
      hasError = true;
      showErrorSnackBar(locationError.value);
      focusLocation.requestFocus();
      return false;
    }

    // Validate Category
    if (categoryController.text.trim().isEmpty) {
      categoryError.value =
      '${AppLocalizations.of(Get.context!)!.category} ${AppLocalizations.of(Get.context!)!.cant_empty}';
      hasError = true;
      showErrorSnackBar(categoryError.value);
      focusCategory.requestFocus();
      return false;
    }

    // Validate Start Date
    if (startDateController.text.trim().isEmpty) {
      startDateError.value =
      '${AppLocalizations.of(Get.context!)!.start_date} ${AppLocalizations.of(Get.context!)!.cant_empty}';
      hasError = true;
      showErrorSnackBar(startDateError.value);
      focusStartDate.requestFocus();
      return false;
    }

    // Validate End Date
    if (endDateController.text.trim().isEmpty) {
      endDateError.value =
      '${AppLocalizations.of(Get.context!)!.end_date} ${AppLocalizations.of(Get.context!)!.cant_empty}';
      hasError = true;
      showErrorSnackBar(endDateError.value);
      focusEndDate.requestFocus();
      return false;
    }

    // Validate Start Time
    if (startTimeController.text.trim().isEmpty) {
      startTimeError.value =
      '${AppLocalizations.of(Get.context!)!.start_time} ${AppLocalizations.of(Get.context!)!.cant_empty}';
      hasError = true;
      showErrorSnackBar(startTimeError.value);
      focusStartTime.requestFocus();
      return false;
    }

    // Validate End Time
    if (endTimeController.text.trim().isEmpty) {
      endTimeError.value =
      '${AppLocalizations.of(Get.context!)!.end_time} ${AppLocalizations.of(Get.context!)!.cant_empty}';
      hasError = true;
      showErrorSnackBar(endTimeError.value);
      focusEndTime.requestFocus();
      return false;
    }

    // Validate Description
    if (descriptionController.text.trim().isEmpty) {
      descriptionError.value =
      '${AppLocalizations.of(Get.context!)!.description} ${AppLocalizations.of(Get.context!)!.cant_empty}';
      hasError = true;
      showErrorSnackBar(descriptionError.value);
      focusDescription.requestFocus();
      return false;
    }

    // Validate Poster
    if (selectedImage.value == null) {
      hasError = true;
      showErrorSnackBar('Event poster is required');
      return false;
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
        showErrorSnackBar('${types[i]} ticket price cannot be empty');
        hasError = true;
        return false;
      } else {
        // Ensure price is a valid number
        if (double.tryParse(ticketPriceController[i].text) == null) {
          ticketPriceController[i].text = '0';
          showErrorSnackBar('${types[i]} ticket price must be a valid number');
          hasError = true;
          return false;
        }
      }

      // Validate ticket quantity
      if (ticketQuantityController[i].text.trim().isEmpty) {
        ticketQuantityController[i].text = '0';
        showErrorSnackBar('${types[i]} ticket quantity cannot be empty');
        hasError = true;
        return false;
      } else {
        // Ensure quantity is a valid integer
        if (int.tryParse(ticketQuantityController[i].text) == null) {
          ticketQuantityController[i].text = '0';
          showErrorSnackBar('${types[i]} ticket quantity must be a valid number');
          hasError = true;
          return false;
        }
      }
    }

    // Validate Card Number
    cardType.value = getCardType(cardNumberController.text.trim());
    if (cardNumberController.text.trim().isEmpty) {
      cardNumberError.value = true;
      showErrorSnackBar('Card number cannot be empty');
      hasError = true;
      cardNumberFocus.requestFocus();
      return false;
    } else if (!RegExp(r'^[0-9]{13,19}$').hasMatch(cardNumberController.text) ||
        cardType.value == 'Unknown') {
      cardNumberError.value = true;
      showErrorSnackBar('Please enter a valid card number');
      hasError = true;
      cardNumberFocus.requestFocus();
      return false;
    }

    // Validate Card Holder
    if (cardHolderController.text.isEmpty) {
      cardHolderError.value = true;
      showErrorSnackBar('Card holder name cannot be empty');
      hasError = true;
      cardHolderFocus.requestFocus();
      return false;
    } else if (!RegExp(r'^[a-zA-Z\s\-]+$')
        .hasMatch(cardHolderController.text)) {
      cardHolderError.value = true;
      showErrorSnackBar('Please enter a valid card holder name');
      hasError = true;
      cardHolderFocus.requestFocus();
      return false;
    }

    // Validate CCV
    if (ccvController.text.trim().isEmpty) {
      ccvError.value = true;
      showErrorSnackBar('CCV cannot be empty');
      hasError = true;
      ccvFocus.requestFocus();
      return false;
    } else if (!RegExp(r'^[0-9]{3,4}$').hasMatch(ccvController.text)) {
      ccvError.value = true;
      showErrorSnackBar('Please enter a valid CCV');
      hasError = true;
      ccvFocus.requestFocus();
      return false;
    }

    // Validate Expire Date
    if (expireDateController.text.trim().isEmpty) {
      expireDateError.value = true;
      showErrorSnackBar('Expiration date cannot be empty');
      hasError = true;
      expireDateFocus.requestFocus();
      return false;
    } else if (!RegExp(r'^(0[1-9]|1[0-2])\/[0-9]{2}$')
        .hasMatch(expireDateController.text)) {
      expireDateError.value = true;
      showErrorSnackBar('Please enter a valid expiration date (MM/YY)');
      hasError = true;
      expireDateFocus.requestFocus();
      return false;
    }

    // If we got here, all validations passed
    return true;
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
            duration: const Duration(milliseconds: 800),
          );
        } else {
          String errorMessage =
              response.data['message'] ?? 'Event creation failed';

          if (response.data['errors'] != null &&
              response.data['errors'] is Map) {
            errorMessage +=
                "\n${(response.data['errors'] as Map).values.expand((e) => e).join("\n")}";
          }

          Get.snackbar(
            'Error',
            errorMessage,
            snackPosition: SnackPosition.TOP,
          );
        }
      } on DioException catch (e) {
        print('Dio Error: ${e.response?.data['errors']}');
        print('Error Message: ${e.message}');
        print('Status Code: ${e.response?.statusCode}');

        String errorMessage =
            e.response?.data['message'] ?? 'Event creation failed';

        if (e.response?.data['errors'] != null &&
            e.response?.data['errors'] is Map) {
          errorMessage +=
              "\n${(e.response?.data['errors'] as Map).values.expand((e) => e).join("\n")}";
        }

        Get.snackbar(
          'Error',
          errorMessage,
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
