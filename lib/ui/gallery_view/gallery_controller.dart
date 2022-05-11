import 'dart:io';

import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_gallery/photo_gallery.dart';

class GalleryController extends GetxController {
  RxBool isLoading = false.obs;

  var isPermissionGranted = true.obs;

  var imageAlbums = [].obs;

  @override
  void onInit() {
    super.onInit();
    getPermissions();
  }

  getPermissions() async {
    if (Platform.isIOS &&
            await Permission.storage.request().isGranted &&
            await Permission.photos.request().isGranted ||
        Platform.isAndroid && await Permission.storage.request().isGranted) {
      isPermissionGranted(true);
      getImages();
    } else {
      isPermissionGranted(false);
      print("Permission Declined");
      // Get.snackbar(
      //     "Permission required", "Photos and storage permission required");
    }
  }

  getImages() async {
    isLoading(true);
    imageAlbums(await PhotoGallery.listAlbums(
      mediumType: MediumType.image,
    ));
    isLoading(false);
  }
}
