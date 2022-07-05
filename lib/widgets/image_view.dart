import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageView extends StatefulWidget {
  ImageView({Key key}) : super(key: key);

  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("2333"),
      ),
      bottomNavigationBar: TextButton(
        onPressed: () => print("object"),
        child: Text(
          "下载",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
          child: PhotoView(
        imageProvider: AssetImage("assets/large-image.jpg"),
      )),
    );
  }
}
