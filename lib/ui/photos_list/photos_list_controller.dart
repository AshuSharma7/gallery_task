import 'package:get/get.dart';
import 'package:photo_gallery/photo_gallery.dart';

class PhotosListController extends GetxController {
  final Album album;
  PhotosListController(this.album);
  RxBool isLoading = false.obs;
  RxBool isNextPageLoading = false.obs;

  var media = [].obs;
  @override
  void onInit() {
    super.onInit();
    getPhotos(album);
  }

  getPhotos(Album album) async {
    isLoading(true);
    media((await album.listMedia()).items);
    isLoading(false);
    print(media.length);
  }
}
