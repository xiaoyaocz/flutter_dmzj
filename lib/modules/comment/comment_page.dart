import 'package:flutter/material.dart';
import 'package:flutter_dmzj/modules/comment/comment_controller.dart';
import 'package:get/get.dart';

class CommentPage extends GetView<CommentController> {
  const CommentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("评论"),
      ),
    );
  }
}
