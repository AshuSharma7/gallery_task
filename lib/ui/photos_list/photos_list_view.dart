import 'package:flutter/material.dart';
import 'package:gallery_task/ui/photo/photo_view.dart';
import 'package:gallery_task/ui/photos_list/photos_list_controller.dart';
import 'package:get/get.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:transparent_image/transparent_image.dart';

class PhotosListView extends StatelessWidget {
  final Album album;
  const PhotosListView({Key? key, required this.album}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final photosController = Get.put(PhotosListController(album));
    return Obx(() => Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50.0,
              ),
              Row(
                children: [
                  IconButton(
                      visualDensity: const VisualDensity(horizontal: -1),
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(Icons.arrow_back_ios)),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 0),
                    child: Hero(
                      tag: album.name ?? "",
                      child: Material(
                        color: Colors.transparent,
                        child: Text(
                          album.name ?? "",
                          style: const TextStyle(
                              fontSize: 40.0, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              photosController.isLoading.isTrue
                  ? const Center(
                      child: Text(
                        "Loading...",
                        style: TextStyle(color: Colors.black),
                      ),
                    )
                  : Expanded(
                      child: GridView.builder(
                          padding: const EdgeInsets.only(top: 20.0),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          itemCount: photosController.media.length,
                          itemBuilder: (context, index) {
                            Medium media = photosController.media[index];
                            return GestureDetector(
                              onTap: () {
                                Get.to(() => PhotoView(media: media));
                              },
                              child: Hero(
                                tag: media.id,
                                child: Container(
                                  child: FadeInImage(
                                    fit: BoxFit.cover,
                                    placeholder: MemoryImage(kTransparentImage),
                                    image: ThumbnailProvider(
                                      mediumId: media.id,
                                      mediumType: media.mediumType,
                                      highQuality: true,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }))
            ],
          ),
        ));
  }
}
