part of '../views/first_signup_view.dart';

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
    try {
      countries = await Countries.fetchCountries();

      // Find Cambodia (KH), or set a default
      var filterCountry = countries.firstWhere(
        (c) => c.countryCode == 'KH',
        orElse: () => CountryInfo(
          name: 'Unknown',
          flag: 'assets/image/flags/kh.png', // Fallback flag
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

  void loadMore() {
    if (currentLenght.value < countries.length) {
      currentLenght.value = (currentLenght.value + 20).clamp(
        0,
        countries.length,
      );
    }
  }
}
