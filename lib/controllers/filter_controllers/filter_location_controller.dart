part of '../../views/filter_views/filter_location.dart';

class FilterLocationController extends GetxController {
  late Map<String, dynamic> cambodiaProvinces;
  var searchLocation = <String, dynamic>{}.obs;
  var searchController = TextEditingController();
  var selectedValue = ''.obs;

  void initializeProvinces(BuildContext context) {
    cambodiaProvinces = {
      "banteay_meanchey": AppLocalizations.of(context)!.banteay_meanchey,
      "battambang": AppLocalizations.of(context)!.battambang,
      "kampong_cham": AppLocalizations.of(context)!.kampong_cham,
      "kampong_chhnang": AppLocalizations.of(context)!.kampong_chhnang,
      "kampong_speu": AppLocalizations.of(context)!.kampong_speu,
      "kampong_thom": AppLocalizations.of(context)!.kampong_thom,
      "kampot": AppLocalizations.of(context)!.kampot,
      "kandal": AppLocalizations.of(context)!.kandal,
      "koh_kong": AppLocalizations.of(context)!.koh_kong,
      "kratie": AppLocalizations.of(context)!.kratie,
      "mondulkiri": AppLocalizations.of(context)!.mondulkiri,
      "oddar_meanchey": AppLocalizations.of(context)!.oddar_meanchey,
      "pailin": AppLocalizations.of(context)!.pailin,
      "preah_vihear": AppLocalizations.of(context)!.preah_vihear,
      "prey_veng": AppLocalizations.of(context)!.prey_veng,
      "pursat": AppLocalizations.of(context)!.pursat,
      "ratanakiri": AppLocalizations.of(context)!.rattanakiri,
      "siem_reap": AppLocalizations.of(context)!.siem_reap,
      "preah_sihanouk": AppLocalizations.of(context)!.preah_sihanouk,
      "stung_treng": AppLocalizations.of(context)!.stung_treng,
      "svay_rieng": AppLocalizations.of(context)!.svay_rieng,
      "takeo": AppLocalizations.of(context)!.takeo,
      "kep": AppLocalizations.of(context)!.kep,
      "phnom_penh": AppLocalizations.of(context)!.phnom_penh,
      "tboung_khmum": AppLocalizations.of(context)!.tboung_khmum,
    };
    searchLocation.value = cambodiaProvinces;
  }

  void updateSearchLocation(Map<String, dynamic> newLocations) {
    searchLocation.value =
        newLocations; 
  }

  @override
  void onInit() {
    super.onInit();
    initializeProvinces(Get.context!);
    selectedValue.value = Get.find<FilterController>().selectedLocation.value;
  }
}
