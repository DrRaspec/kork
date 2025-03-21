part of 'select_profile_view.dart';

class SelectProfileController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  var selectedImage = Rx<File?>(null);
  final dio = Dio();

  Future<void> pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      selectedImage.value = File(image.path);
    }
  }

  Future<File> loadDefualtImage() async {
    final byteData = await rootBundle.load('assets/image/profile.png');
    final file = await getTemporaryFile(byteData);
    return file;
  }

  Future<File> getTemporaryFile(ByteData byteData) async {
    final tempDir = await getTemporaryDirectory();
    final file =
        File('${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.png');
    await file.writeAsBytes(byteData.buffer.asInt8List());
    return file;
  }
}

// Platform.isAndroid check on using device
