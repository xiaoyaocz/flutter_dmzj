import 'package:flutter/material.dart';
import 'package:flutter_dmzj/app/app_style.dart';
import 'package:flutter_dmzj/widgets/net_image.dart';
import 'package:remixicon/remixicon.dart';

class UserPhoto extends StatelessWidget {
  final String? url;
  final bool showBoder;
  final double size;
  const UserPhoto({
    this.url,
    this.showBoder = true,
    this.size = 48,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (url == null || (url?.isEmpty ?? true)) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          border: showBoder
              ? Border.all(
                  color: Colors.grey.withOpacity(.2),
                )
              : null,
          color: Colors.grey.withOpacity(.2),
          borderRadius: AppStyle.radius32,
        ),
        child: const Icon(
          Remix.user_fill,
          color: Colors.white,
          size: 24,
        ),
      );
    }
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(56),
        border: showBoder
            ? Border.all(
                color: Colors.grey.withOpacity(.2),
              )
            : null,
      ),
      child: NetImage(
        url!,
        width: size,
        height: size,
        borderRadius: size,
      ),
    );
  }
}
