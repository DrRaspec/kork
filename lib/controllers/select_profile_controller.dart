part of '../views/select_profile_view.dart';

class SelectProfileController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  var selectedImage = Rx<File?>(null);

  Future<void> pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      selectedImage.value = File(image.path);
    }
  }
}
