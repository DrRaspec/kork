part of 'add_event_view.dart';

class AddEventViewController extends GetxController {
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

  @override
  void onInit() {
    super.onInit();
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
}
