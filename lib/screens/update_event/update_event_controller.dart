part of 'update_event_view.dart';

class UpdateEventViewController extends GetxController {
  // List<String> ticketTypes = ["1 Type", "2 Types", "3 Types", "4 Types"].obs;
  var argument = Get.arguments as HostedEvent;
  List<String> types = ["Standard", "Normal", "VIP", "VVIP"].obs;
  var ticketController = <TextEditingController>[].obs;
  var ticketPriceController = <TextEditingController>[].obs;
  var ticketQuantityController = <TextEditingController>[].obs;
  var ticketCount = 0;
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

  var address = '';
  var poster = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // updateControllers(selectedValue.value);
    cardNumberFocus = FocusNode();
    cardHolderFocus = FocusNode();
    ccvFocus = FocusNode();
    expireDateFocus = FocusNode();
    init();
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

  void init() {
    nameController.text = argument.eventName;
    getLocationAddress();
    categoryController.text = argument.eventType;
    startDateController.text =
        DateFormat('yyyy-MM-dd').format(argument.startDate);
    endDateController.text = DateFormat('yyyy-MM-dd').format(argument.endDate);
    startTimeController.text = formatTime(argument.startTime);
    endTimeController.text = formatTime(argument.endTime);
    descriptionController.text = argument.description;

    ticketController.clear();
    ticketPriceController.clear();
    ticketQuantityController.clear();

    ticketCount = argument.tickets.length;

    for (int i = 0; i < ticketCount; i++) {
      Ticket ticket = argument.tickets[i];

      // Add new controllers
      ticketController.add(
          TextEditingController(text: ticket.ticketType.firstCapitalize()));
      ticketPriceController
          .add(TextEditingController(text: ticket.price?.toString() ?? '0'));
      ticketQuantityController
          .add(TextEditingController(text: ticket.qty.toString()));
    }
    print('ticket lenght ${ticketController.length}');
    print(
        "Ticket data: ${argument.tickets.map((t) => '${t.ticketType}: ${t.qty}').join(', ')}");
    poster.value = argument.posterUrl ?? 'Unknown';
  }

  void getLocationAddress() async {
    try {
      final placemarks = await placemarkFromCoordinates(
        argument.location.latitude,
        argument.location.longitude,
      );

      if (placemarks.isNotEmpty) {
        final mark = placemarks.first;

        final List<String> addressParts = [
          mark.name ?? '',
          mark.thoroughfare ?? '',
          mark.subThoroughfare ?? '',
          mark.subLocality ?? '',
          mark.subAdministrativeArea ?? '',
          mark.administrativeArea ?? mark.locality ?? '',
          mark.country ?? '',
        ].where((element) => element.isNotEmpty).toList();

        locationController.text = addressParts.join(', ');

        // print('Placemark data: ${mark.toString()}');
      }
    } catch (e) {
      locationController.text = 'Unable to fetch address';
      print('Error fetching address: $e');
    }
  }

  // void updateControllers(String? value) {
  //   int count = int.tryParse(value?.split(" ")[0] ?? "0") ?? 0;
  //
  //   for (var controller in ticketController) {
  //     controller.dispose();
  //   }
  //   ticketController.clear();
  //   for (var controller in ticketPriceController) {
  //     controller.dispose();
  //   }
  //   ticketPriceController.clear();
  //
  //   for (int i = 0; i < count; i++) {
  //     ticketController.add(TextEditingController());
  //     ticketPriceController.add(TextEditingController());
  //   }
  // }

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
      showErrorSnackBar(nameError.value);
      focusName.requestFocus();
      return false;
    }

    // Validate Location
    if (locationController.text.trim().isEmpty) {
      locationError.value =
          '${AppLocalizations.of(Get.context!)!.location} ${AppLocalizations.of(Get.context!)!.cant_empty}';
      showErrorSnackBar(locationError.value);
      focusLocation.requestFocus();
      return false;
    }

    // Validate Category
    if (categoryController.text.trim().isEmpty) {
      categoryError.value =
          '${AppLocalizations.of(Get.context!)!.category} ${AppLocalizations.of(Get.context!)!.cant_empty}';
      showErrorSnackBar(categoryError.value);
      focusCategory.requestFocus();
      return false;
    }

    // Validate Start Date
    if (startDateController.text.trim().isEmpty) {
      startDateError.value =
          '${AppLocalizations.of(Get.context!)!.start_date} ${AppLocalizations.of(Get.context!)!.cant_empty}';
      showErrorSnackBar(startDateError.value);
      focusStartDate.requestFocus();
      return false;
    }

    // Validate End Date
    if (endDateController.text.trim().isEmpty) {
      endDateError.value =
          '${AppLocalizations.of(Get.context!)!.end_date} ${AppLocalizations.of(Get.context!)!.cant_empty}';
      showErrorSnackBar(endDateError.value);
      focusEndDate.requestFocus();
      return false;
    }

    // Validate Start Time
    if (startTimeController.text.trim().isEmpty) {
      startTimeError.value =
          '${AppLocalizations.of(Get.context!)!.start_time} ${AppLocalizations.of(Get.context!)!.cant_empty}';
      showErrorSnackBar(startTimeError.value);
      focusStartTime.requestFocus();
      return false;
    }

    // Validate End Time
    if (endTimeController.text.trim().isEmpty) {
      endTimeError.value =
          '${AppLocalizations.of(Get.context!)!.end_time} ${AppLocalizations.of(Get.context!)!.cant_empty}';
      showErrorSnackBar(endTimeError.value);
      focusEndTime.requestFocus();
      return false;
    }

    // Validate Description
    if (descriptionController.text.trim().isEmpty) {
      descriptionError.value =
          '${AppLocalizations.of(Get.context!)!.description} ${AppLocalizations.of(Get.context!)!.cant_empty}';
      showErrorSnackBar(descriptionError.value);
      focusDescription.requestFocus();
      return false;
    }

    // Validate Poster - Only validate if updating poster
    if (selectedImage.value == null && argument.posterUrl == null) {
      showErrorSnackBar('Event poster is required');
      return false;
    }

    // Validate Date Range
    if (startDateController.text.isNotEmpty &&
        endDateController.text.isNotEmpty) {
      try {
        DateTime startDate = DateTime.parse(startDateController.text);
        DateTime endDate = DateTime.parse(endDateController.text);

        if (endDate.isBefore(startDate)) {
          endDateError.value =
              '${AppLocalizations.of(Get.context!)!.end_date} cannot be before ${AppLocalizations.of(Get.context!)!.start_date}';
          showErrorSnackBar(endDateError.value);
          focusEndDate.requestFocus();
          return false;
        }

        Duration difference = endDate.difference(startDate);
        if (difference.inDays > 30) {
          endDateError.value =
              '${AppLocalizations.of(Get.context!)!.end_date} cannot be more than 30 days after ${AppLocalizations.of(Get.context!)!.start_date}';
          showErrorSnackBar(endDateError.value);
          focusEndDate.requestFocus();
          return false;
        }

        // If same day, validate times
        if (difference.inDays == 0 &&
            startTimeController.text.isNotEmpty &&
            endTimeController.text.isNotEmpty) {
          final startTimeParts = startTimeController.text.split(':');
          final endTimeParts = endTimeController.text.split(':');

          if (startTimeParts.length >= 2 && endTimeParts.length >= 2) {
            final startHour = int.tryParse(startTimeParts[0]) ?? 0;
            final startMinute = int.tryParse(startTimeParts[1]) ?? 0;
            final endHour = int.tryParse(endTimeParts[0]) ?? 0;
            final endMinute = int.tryParse(endTimeParts[1]) ?? 0;

            if (endHour < startHour ||
                (endHour == startHour && endMinute <= startMinute)) {
              endTimeError.value =
                  '${AppLocalizations.of(Get.context!)!.end_time} must be after ${AppLocalizations.of(Get.context!)!.start_time}';
              showErrorSnackBar(endTimeError.value);
              focusEndTime.requestFocus();
              return false;
            }
          }
        }
      } catch (e) {
        print("Date validation error: $e");
        showErrorSnackBar("Invalid date format");
        return false;
      }
    }

    // Validate Ticket Types, Prices, and Quantities
    for (int i = 0; i < ticketCount; i++) {
      // Validate ticket type
      if (i < ticketController.length &&
          ticketController[i].text.trim().isEmpty) {
        // Default to a type if empty
        if (i < types.length) {
          ticketController[i].text = '${types[i]} Ticket';
        } else {
          ticketController[i].text = 'Ticket ${i + 1}';
        }
      }

      // Validate ticket price
      if (i < ticketPriceController.length) {
        if (ticketPriceController[i].text.trim().isEmpty) {
          ticketPriceController[i].text = '0';
          showErrorSnackBar('Ticket price cannot be empty');
          return false;
        } else {
          // Ensure price is a valid number
          if (double.tryParse(ticketPriceController[i].text) == null) {
            ticketPriceController[i].text = '0';
            showErrorSnackBar('Ticket price must be a valid number');
            return false;
          } else if (double.parse(ticketPriceController[i].text) <= 0) {
            // Ensure price is positive
            showErrorSnackBar('Ticket price cannot be zero or negative');
            return false;
          }
        }
      }

      // Validate ticket quantity
      if (i < ticketQuantityController.length) {
        if (ticketQuantityController[i].text.trim().isEmpty) {
          ticketQuantityController[i].text = '0';
          showErrorSnackBar('Ticket quantity cannot be empty');
          return false;
        } else {
          // Ensure quantity is a valid integer
          if (int.tryParse(ticketQuantityController[i].text) == null) {
            ticketQuantityController[i].text = '0';
            showErrorSnackBar('Ticket quantity must be a valid number');
            return false;
          } else if (int.parse(ticketQuantityController[i].text) <= 0) {
            // Ensure quantity is positive
            showErrorSnackBar('Ticket quantity cannot be zero or negative');
            return false;
          }
        }
      }
    }

    // Validate Card Number
    cardType.value = getCardType(cardNumberController.text.trim());
    if (cardNumberController.text.trim().isEmpty) {
      cardNumberError.value = true;
      showErrorSnackBar('Card number cannot be empty');
      cardNumberFocus.requestFocus();
      return false;
    } else if (!RegExp(r'^[0-9]{13,19}$').hasMatch(cardNumberController.text) ||
        cardType.value == 'Unknown') {
      cardNumberError.value = true;
      showErrorSnackBar('Please enter a valid card number');
      cardNumberFocus.requestFocus();
      return false;
    }

    // Validate Card Holder
    if (cardHolderController.text.isEmpty) {
      cardHolderError.value = true;
      showErrorSnackBar('Card holder name cannot be empty');
      cardHolderFocus.requestFocus();
      return false;
    } else if (!RegExp(r'^[a-zA-Z\s\-]+$')
        .hasMatch(cardHolderController.text)) {
      cardHolderError.value = true;
      showErrorSnackBar('Please enter a valid card holder name');
      cardHolderFocus.requestFocus();
      return false;
    }

    // Validate CCV
    if (ccvController.text.trim().isEmpty) {
      ccvError.value = true;
      showErrorSnackBar('CCV cannot be empty');
      ccvFocus.requestFocus();
      return false;
    } else if (!RegExp(r'^[0-9]{3,4}$').hasMatch(ccvController.text)) {
      ccvError.value = true;
      showErrorSnackBar('Please enter a valid CCV');
      ccvFocus.requestFocus();
      return false;
    }

    // Validate Expire Date
    if (expireDateController.text.trim().isEmpty) {
      expireDateError.value = true;
      showErrorSnackBar('Expiration date cannot be empty');
      expireDateFocus.requestFocus();
      return false;
    } else if (!RegExp(r'^(0[1-9]|1[0-2])\/[0-9]{2}$')
        .hasMatch(expireDateController.text)) {
      expireDateError.value = true;
      showErrorSnackBar('Please enter a valid expiration date (MM/YY)');
      expireDateFocus.requestFocus();
      return false;
    } else {
      try {
        String expDateStr = expireDateController.text;
        List<String> parts = expDateStr.split('/');
        int month = int.parse(parts[0]);
        int year = int.parse(parts[1]) + 2000; // Convert '25' to '2025'

        DateTime expDate =
            DateTime(year, month + 1, 0); // Last day of the month
        if (expDate.isBefore(DateTime.now())) {
          expireDateError.value = true;
          showErrorSnackBar('Card expiration date cannot be in the past');
          expireDateFocus.requestFocus();
          return false;
        }
      } catch (e) {
        expireDateError.value = true;
        showErrorSnackBar('Invalid expiration date format');
        expireDateFocus.requestFocus();
        return false;
      }
    }

    // If we got here, all validations passed
    return true;
  }

  void onSubmit() async {
    if (checkValidation()) {
      try {
        String formattedStartTime = startTimeController.text;
        String formattedEndTime = endTimeController.text;

        if (formattedStartTime.split(':').length == 2) {
          String hour = formattedStartTime.split(':')[0].padLeft(2, '0');
          String minute = formattedStartTime.split(':')[1].padLeft(2, '0');
          formattedStartTime = "$hour:$minute"; // HH:MM format
        }

        if (formattedEndTime.split(':').length == 2) {
          String hour = formattedEndTime.split(':')[0].padLeft(2, '0');
          String minute = formattedEndTime.split(':')[1].padLeft(2, '0');
          formattedEndTime = "$hour:$minute"; // HH:MM format
        }

        print('formattedStartTime $formattedStartTime');
        print('formattedStartTime $formattedEndTime');

        var formData = FormData.fromMap({
          '_method': 'PUT',
          'event_name': nameController.text,
          'event_type': categoryController.text.toLowerCase(),
          'description': descriptionController.text,
          'location': address.isEmpty
              ? '${argument.location.latitude},${argument.location.longitude}'
              : address,
          'start_date': startDateController.text,
          'end_date': endDateController.text,
          'start_time': formattedStartTime,
          'end_time': formattedEndTime,
        });

        if (selectedImage.value != null) {
          formData.files.add(MapEntry(
              'poster_url',
              await MultipartFile.fromFile(
                selectedImage.value!.path,
                filename:
                    'event_poster.${selectedImage.value!.path.split('.').last}',
              )));
        }

        for (int i = 0; i < ticketCount; i++) {
          formData.fields.add(MapEntry('tickets[$i][ticket_type]',
              ticketController[i].text.toLowerCase()));
          formData.fields.add(
              MapEntry('tickets[$i][price]', ticketPriceController[i].text));
          formData.fields.add(
              MapEntry('tickets[$i][qty]', ticketQuantityController[i].text));

          if (i < argument.tickets.length) {
            formData.fields.add(
                MapEntry('tickets[$i][id]', argument.tickets[i].id.toString()));
          }
        }

        const storage = FlutterSecureStorage();
        var token = await storage.read(key: 'token') ?? 'error';
        EventApiHelper.setToken(token);

        var response =
            await EventApiHelper.post('/events/${argument.id}', data: formData);

        print('Response Status Code: ${response.statusCode}');
        print('Response Data: ${response.data}');

        if (response.statusCode == 200 || response.statusCode == 201) {
          var hostedEvent = HostedEvent.fromJson(response.data);
          Get.back(result: hostedEvent);

          Get.snackbar(
            'Success',
            'Event updated successfully',
            snackPosition: SnackPosition.TOP,
          );
        } else {
          String errorMessage =
              response.data['message'] ?? 'Event update failed';

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
        print('Dio Error: ${e.response?.data}');
        String errorMessage =
            e.response?.data['message'] ?? 'Event update failed';

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
