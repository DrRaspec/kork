part of '../views/sign_up_view/select_profile_view.dart';

class SelectProfileController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  var selectedImage = Rx<File?>(null);
  var isClick = false.obs;

  Future<void> pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      selectedImage.value = File(image.path);
    }
  }

  Future<void> _showDialog() {
    return showModalBottomSheet(
      context: Get.context!,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
        ),
      ),
      backgroundColor: const Color(0xff333333),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          height: 134,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.end,
            spacing: 56,
            children: [
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.only(top: 10),
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    spacing: 3,
                    children: [
                      Image.asset(
                        Platform.isAndroid
                            ? 'assets/image/android_gallery.png'
                            : 'assets/image/ios_gallery.png',
                        width: 64,
                      ),
                      Text(
                        AppLocalizations.of(context)!.gallery,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xffEAE9FC),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 48,
                width: 1,
                margin: const EdgeInsets.only(bottom: 14),
                color: const Color(0x80EAE9FC),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                spacing: 3,
                children: [
                  Image.asset(
                    Platform.isAndroid
                        ? 'assets/image/android_camera.png'
                        : 'assets/image/ios_camera.png',
                    width: 64,
                  ),
                  Text(
                    AppLocalizations.of(context)!.camera,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xffEAE9FC),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void onPress() {
    isClick.value = true;

    Future.delayed(const Duration(milliseconds: 500), () {
      if (Get.isRegistered<SelectProfileController>()) {
        isClick.value = false;
      }
    });
  }
}

// Platform.isAndroid check on using device
