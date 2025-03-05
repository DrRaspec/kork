part of 'select_profile_view.dart';

class SelectProfileController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  var selectedImage = Rx<File?>(null);

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
          height: 106,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.end,
            spacing: 16,
            children: [
              Expanded(
                child: SizedBox(
                  width: 74,
                  height: 90,
                  child: GestureDetector(
                    onTap: () {
                      pickImage(ImageSource.gallery);
                      Get.back();
                    },
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        spacing: 3,
                        children: [
                          Image.asset(
                            Platform.isAndroid
                                ? 'assets/image/android_gallery.png'
                                : 'assets/image/ios_gallery.png',
                            width: 48,
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
                ),
              ),
              Container(
                height: 32,
                width: 1,
                margin: const EdgeInsets.only(bottom: 10),
                color: const Color(0x80EAE9FC),
              ),
              Expanded(
                child: SizedBox(
                  width: 74,
                  height: 90,
                  child: GestureDetector(
                    onTap: () {
                      pickImage(ImageSource.camera);
                      Get.back();
                    },
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        spacing: 3,
                        children: [
                          Image.asset(
                            Platform.isAndroid
                                ? 'assets/image/android_camera.png'
                                : 'assets/image/ios_camera.png',
                            width: 48,
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
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// Platform.isAndroid check on using device
