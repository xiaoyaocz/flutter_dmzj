import 'package:flutter/material.dart';

class AppErrorWidget extends StatelessWidget {
  final String message;
  final Function()? onRefresh;
  const AppErrorWidget(this.message, {this.onRefresh, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.warning,
            size: 48,
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            message,
            style: const TextStyle(color: Colors.grey),
          ),
          Visibility(
            visible: onRefresh != null,
            child: TextButton(
              onPressed: onRefresh,
              child: const Text("刷新"),
            ),
          ),
        ],
      ),
    );
  }
}
