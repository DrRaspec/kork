import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kork/routes/routes.dart';
import 'package:kork/screens/sign_up_view/select_location/select_location_view.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

part 'map_controller.dart';
part 'map_binding.dart';

class MapView extends GetView<MapController> {
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            Expanded(
              child: Stack(
                children: [
                  Obx(
                    () => GoogleMap(
                      initialCameraPosition: controller.initialCameraPosition,
                      markers: Set<Marker>.from(controller.markers),
                      onTap: controller.handleTap,
                      onMapCreated: (mapCtrl) =>
                          controller.googleMapController = mapCtrl,
                      myLocationEnabled: true,
                      myLocationButtonEnabled: false,
                      zoomControlsEnabled: false,
                    ),
                  ),
                  Positioned(
                    top: 16,
                    left: 16,
                    right: 16,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: Get.back,
                          child: const Icon(
                            Icons.arrow_back_ios_new_outlined,
                            size: 24,
                            color: Color(0xffEAE9FC),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Container(
                            height: 40,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: TextField(
                              controller: controller.searchController,
                              textAlignVertical: TextAlignVertical.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: Get.theme.colorScheme.tertiary,
                              ),
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 8,
                                ),
                                prefixIcon: controller.isSearching.value
                                    ? const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: CircularProgressIndicator(
                                            strokeWidth: 2),
                                      )
                                    : Icon(
                                        Icons.search,
                                        color:
                                            Get.theme.colorScheme.surfaceTint,
                                        size: 24,
                                      ),
                                suffixIcon: controller
                                        .searchController.text.isNotEmpty
                                    ? GestureDetector(
                                        onTap: () {
                                          controller.searchController.clear();
                                          controller.address.value =
                                              'Click on map to select location';
                                        },
                                        child: Icon(Icons.close,
                                            color: Get
                                                .theme.colorScheme.surfaceTint),
                                      )
                                    : const SizedBox.shrink(),
                                hintText: AppLocalizations.of(context)!
                                    .search_location,
                                hintStyle: TextStyle(
                                  fontSize: 16,
                                  color: Get.theme.colorScheme.surfaceTint,
                                ),
                                filled: true,
                                fillColor: Get
                                    .theme.navigationBarTheme.backgroundColor,
                                border: InputBorder.none,
                              ),
                              onSubmitted: (_) => controller.searchLocation(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    right: 16,
                    child: GestureDetector(
                      onTap: () => controller.goToCurrentLocation(),
                      child: Container(
                        padding: const EdgeInsets.all(13),
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Get.theme.colorScheme.primary,
                        ),
                        child: const Icon(
                          Icons.my_location_outlined,
                          size: 24,
                          color: Color(0xffEAE9FC),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Obx(
              () => Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  controller.address.value,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            GestureDetector(
              onTap: controller.saveLocation,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  width: double.infinity,
                  height: 40,
                  color: Get.theme.colorScheme.primary,
                  alignment: Alignment.center,
                  child: Text(
                    AppLocalizations.of(context)!.confirm,
                    style: const TextStyle(
                      color: Color(0xffEAE9FC),
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
