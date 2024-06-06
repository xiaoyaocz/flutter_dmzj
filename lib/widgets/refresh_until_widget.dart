import 'package:flutter/material.dart';
import 'package:flutter_dmzj/app/app_style.dart';
import 'package:remixicon/remixicon.dart';

/// 一个加载图标会旋转的加载按钮。加载图标（[Remix.refresh_line]）在左，文字（[text])在
/// 右。
///
/// 在点击widget时会在执行[onRefresh]函数的同时旋转加载图标。加载图标会一直旋转直到该函数
/// 返还。
///
/// 加载图标会旋转不小于1秒的时间，即如果[onRefresh]函数在1秒之内执行完毕，加载图标会继续旋
/// 转直到距离onRefresh函数开始执行已经过了1秒。
class RefreshUntilWidget extends StatefulWidget {
  final Future Function() onRefresh;
  final String text;

  const RefreshUntilWidget({
    super.key,
    required this.onRefresh,
    required this.text,
  });

  @override
  State<RefreshUntilWidget> createState() => _RefreshUntilWidgetState();
}

class _RefreshUntilWidgetState extends State<RefreshUntilWidget>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  );
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.linear,
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        _controller.repeat();
        // 确保在网络很好的情况下，动画不会太快结束（至少1秒）
        await Future.wait([
          widget.onRefresh(),
          Future.delayed(const Duration(seconds: 1)),
        ]);
        _controller.stop(canceled: false);
      },
      child: Row(
        children: [
          RotationTransition(
            turns: _animation,
            child: const Icon(Remix.refresh_line, size: 18, color: Colors.grey),
          ),
          AppStyle.hGap4,
          Text(
            widget.text,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
