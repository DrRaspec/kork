part of '../views/sign_up_view/first_signup_view.dart';

class FirstSignupController extends GetxController {
  final formKey = GlobalKey<FormState>();
  var firstName = TextEditingController();
  var lastName = TextEditingController();
  var dob = TextEditingController();
  var phoneNumber = TextEditingController();
  var nationality = TextEditingController();
  var cityProvince = TextEditingController();
  var districtKhan = TextEditingController();
  var communeSangkat = TextEditingController();
  var searchDialog = TextEditingController();

  var firstNameError = ''.obs;
  var lastNameError = ''.obs;
  var genderError = ''.obs;
  var dobError = ''.obs;

  late FocusNode firstNameFocus;
  late FocusNode lastNameFocus;

  var selectedGender = Rxn<String>();
  var pickedDate = Rxn<DateTime>();

  List<dynamic> countries = [];
  // String? selectedCountry;
  var country = Rxn<CountryInfo>();
  var selectedNationality = ''.obs;
  var currentLenght = 20.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    firstNameFocus = FocusNode();
    lastNameFocus = FocusNode();
    try {
      countries = await Countries.fetchCountries();

      var filterCountry = countries.firstWhere(
        (c) => c.countryCode == 'KH',
        orElse: () => CountryInfo(
          name: 'Unknown',
          flag: 'assets/image/flags/kh.png',
          phoneCode: '',
          countryCode: '',
        ),
      );

      country.value = filterCountry;
      selectedNationality.value = country.value!.flag;
    } catch (e) {
      print("Error fetching countries: $e");
    }
  }

  @override
  void onClose() {
    firstName.dispose();
    lastName.dispose();
    dob.dispose();
    phoneNumber.dispose();
    nationality.dispose();
    cityProvince.dispose();
    districtKhan.dispose();
    communeSangkat.dispose();
    searchDialog.dispose();
    firstNameFocus.dispose();
    lastNameFocus.dispose();
    super.onClose();
  }

  void loadMore() {
    if (currentLenght.value < countries.length) {
      currentLenght.value = (currentLenght.value + 20).clamp(
        0,
        countries.length,
      );
    }
  }

  void validateInputs() {
    bool hasError = false;
    firstNameError.value = '';
    lastNameError.value = '';
    genderError.value = '';
    dobError.value = '';

    if (firstName.text.isEmpty) {
      firstNameError.value =
          '${AppLocalizations.of(Get.context!)!.first_name}${AppLocalizations.of(Get.context!)!.cant_empty}';
      hasError = true;
    }
    if (lastName.text.isEmpty) {
      lastNameError.value =
          '${AppLocalizations.of(Get.context!)!.last_name}${AppLocalizations.of(Get.context!)!.cant_empty}';
      hasError = true;
    }
    if (selectedGender.value == null || selectedGender.value!.isEmpty) {
      genderError.value =
          '${AppLocalizations.of(Get.context!)!.gender}${AppLocalizations.of(Get.context!)!.cant_empty}';
      hasError = true;
    }
    if (dob.text.isEmpty) {
      dobError.value =
          '${AppLocalizations.of(Get.context!)!.dob}${AppLocalizations.of(Get.context!)!.cant_empty}';
      hasError = true;
    }

    if (hasError) {
      Future.delayed(Duration.zero, () {
        if (firstNameError.isEmpty && lastNameError.isNotEmpty) {
          lastNameFocus.requestFocus();
        } else if (firstNameError.isNotEmpty) {
          firstNameFocus.requestFocus();
        }
      });
    }
  }
}
