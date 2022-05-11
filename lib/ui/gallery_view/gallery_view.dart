import 'package:flutter/material.dart';
import 'package:gallery_task/ui/gallery_view/gallery_controller.dart';
import 'package:gallery_task/ui/photos_list/photos_list_view.dart';
import 'package:get/get.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:transparent_image/transparent_image.dart';

class GalleryView extends StatelessWidget {
  final galleryController = Get.put(GalleryController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 60.0,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Text(
                    "Photos",
                    style: TextStyle(
                      fontSize: 35.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                      padding: const EdgeInsets.only(top: 10),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      itemCount: galleryController.imageAlbums.length,
                      itemBuilder: (context, index) {
                        var album = galleryController.imageAlbums[index];
                        return GestureDetector(
                          onTap: () {
                            Get.to(() => PhotosListView(album: album));
                          },
                          child: Container(
                            margin: const EdgeInsets.all(10.0),
                            // padding: const EdgeInsets.all(10.0),
                            child: Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                Container(
                                  decoration: BoxDecoration(boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.05),
                                        offset: const Offset(2, 2),
                                        blurRadius: 4,
                                        spreadRadius: 0),
                                  ]),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: FadeInImage(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.4,
                                      fit: BoxFit.cover,
                                      placeholder:
                                          MemoryImage(kTransparentImage),
                                      image: AlbumThumbnailProvider(
                                        albumId: album.id,
                                        mediumType: album.mediumType,
                                        highQuality: false,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      color: Colors.black38),
                                  padding: const EdgeInsets.all(5.0),
                                  margin: const EdgeInsets.only(
                                      right: 10, bottom: 10),
                                  child: Hero(
                                    tag: album.name ?? "",
                                    child: Material(
                                      color: Colors.transparent,
                                      child: Text(
                                        album.name ?? "Unknown",
                                        textAlign: TextAlign.end,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
        ));
  }
}
