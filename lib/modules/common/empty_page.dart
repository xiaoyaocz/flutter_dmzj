import 'package:flutter/material.dart';
import 'package:flutter_dmzj/modules/index/index_page.dart';

class EmptyPage extends StatelessWidget {
  const EmptyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MediaQuery.of(context).size.width <= tabletWidth
        ? Container()
        : const Scaffold(
            body: Center(
              child: Text("动漫之家"),
            ),
          );
  }
}
