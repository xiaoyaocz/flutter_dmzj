import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dmzj/app/app_style.dart';

class NetImage extends StatefulWidget {
  final String picUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final double borderRadius;
  final bool progress;
  const NetImage(this.picUrl,
      {this.width,
      this.height,
      this.fit = BoxFit.cover,
      this.borderRadius = 0,
      this.progress = false,
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
    if (picUrl.contains(".dmzj.com")) {
      picUrl = picUrl.replaceAll(".dmzj.com", ".idmzj.com");
    }
    if (picUrl.isEmpty) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(.1),
        ),
        child: const Icon(
          Icons.image,
          color: Colors.grey,
          size: 24,
        ),
      );
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      child: ExtendedImage.network(
        picUrl,
        fit: widget.fit,
        height: widget.height,
        width: widget.width,
        shape: BoxShape.rectangle,
        handleLoadingProgress: widget.progress,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        headers: const {'Referer': "http://www.dmzj.com/"},
        loadStateChanged: (e) {
          if (e.extendedImageLoadState == LoadState.loading) {
            animationController.reset();
            final double? progress =
                e.loadingProgress?.expectedTotalBytes != null
                    ? e.loadingProgress!.cumulativeBytesLoaded /
                        e.loadingProgress!.expectedTotalBytes!
                    : null;
            if (widget.progress) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(
                      value: progress,
                    ),
                    AppStyle.vGap4,
                    Text(
                      '${((progress ?? 0.0) * 100).toInt()}%',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              );
            }
            return Container(
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(.1),
              ),
              child: const Icon(
                Icons.image,
                color: Colors.grey,
                size: 24,
              ),
            );
          }
          if (e.extendedImageLoadState == LoadState.failed) {
            animationController.reset();
            return Container(
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(.1),
              ),
              child: const Icon(
                Icons.broken_image,
                color: Colors.grey,
                size: 24,
              ),
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
