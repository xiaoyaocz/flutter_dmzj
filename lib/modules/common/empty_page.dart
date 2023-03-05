import 'package:flutter/material.dart';
import 'package:flutter_dmzj/app/app_constant.dart';

class EmptyPage extends StatelessWidget {
  const EmptyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MediaQuery.of(context).size.width <= AppConstant.kTabletWidth
        ? Container()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            body: Center(
              child: Image.asset(
                "assets/images/logo_dmzj.png",
                height: 80,
              ),
            ),
          );
  }
}
