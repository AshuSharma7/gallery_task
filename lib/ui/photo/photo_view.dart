import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gallery_task/utils/dimensions.dart';
import 'package:photo_gallery/photo_gallery.dart';

class PhotoView extends StatelessWidget {
  final Medium media;
  PhotoView({Key? key, required this.media}) : super(key: key);

  final _transformationController = TransformationController();
  TapDownDetails _doubleTapDetails = TapDownDetails();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      extendBodyBehindAppBar: true,
      body: SizedBox(
        height: Size.getHeight(context),
        child: Center(
          child: FutureBuilder<File>(
              future: media.getFile(),
              builder: (context1, AsyncSnapshot<File> image) {
                // if (image.hasData) return const CircularProgressIndicator();
                return Hero(
                    tag: media.id,
                    child: GestureDetector(
                      onDoubleTapDown: _handleDoubleTapDown,
                      onDoubleTap: _handleDoubleTap,
                      child: SizedBox(
                        height: Size.getHeight(context),
                        width: Size.getWidth(context),
                        child: InteractiveViewer(
                            // constrained: false,
                            minScale: 1,
                            clipBehavior: Clip.hardEdge,
                            // boundaryMargin: const EdgeInsets.all(100),
                            // minScale: 0.5,
                            // maxScale: 2,
                            // panEnabled: false,
                            transformationController: _transformationController,
                            child: Image.file(image.data!)),
                      ),
                    ));
              }),
        ),
      ),
    );
  }

  void _handleDoubleTapDown(TapDownDetails details) {
    _doubleTapDetails = details;
  }

  void _handleDoubleTap() {
    if (_transformationController.value != Matrix4.identity()) {
      _transformationController.value = Matrix4.identity();
    } else {
      final position = _doubleTapDetails.localPosition;
      // For a 3x zoom
      _transformationController.value = Matrix4.identity()
        ..translate(-position.dx * 2, -position.dy * 2)
        ..scale(3.0);
      // Fox a 2x zoom
      // ..translate(-position.dx, -position.dy)
      // ..scale(2.0);
    }
  }
}
