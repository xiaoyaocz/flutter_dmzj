import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class NetImage extends StatefulWidget {
  final String picUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final double borderRadius;
  const NetImage(this.picUrl,
      {this.width,
      this.height,
      this.fit = BoxFit.cover,
      this.borderRadius = 0,
      Key? key})
      : super(key: key);

  @override
  State<NetImage> createState() => _NetImageState();
}

class _NetImageState extends State<NetImage>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var picUrl = widget.picUrl;
    if (picUrl.contains("dmzj1.com")) {
      picUrl = picUrl.replaceAll("dmzj1.com", "dmzj.com");
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      child: ExtendedImage.network(
        picUrl,
        fit: widget.fit,
        height: widget.height,
        width: widget.width,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        headers: const {'Referer': "http://www.dmzj.com/"},
        loadStateChanged: (e) {
          if (e.extendedImageLoadState == LoadState.loading) {
            return const Icon(
              Icons.image,
              color: Colors.grey,
              size: 24,
            );
          }
          if (e.extendedImageLoadState == LoadState.failed) {
            return const Icon(
              Icons.broken_image,
              color: Colors.grey,
              size: 24,
            );
          }
          if (e.extendedImageLoadState == LoadState.completed) {
            if (e.wasSynchronouslyLoaded) {
              return e.completedWidget;
            }
            animationController.forward();

            return FadeTransition(
              opacity: animationController,
              child: e.completedWidget,
            );
          }
          return null;
        },
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
