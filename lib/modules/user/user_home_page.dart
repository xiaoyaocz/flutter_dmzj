import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dmzj/app/app_color.dart';
import 'package:flutter_dmzj/app/app_style.dart';
import 'package:flutter_dmzj/modules/user/user_home_controller.dart';
import 'package:flutter_dmzj/services/user_service.dart';
import 'package:flutter_dmzj/widgets/net_image.dart';
import 'package:flutter_dmzj/widgets/user_photo.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';
import 'package:url_launcher/url_launcher_string.dart';

class UserHomePage extends GetView<UserHomeController> {
  const UserHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.isDarkMode
          ? AppColor.backgroundColorDark
          : AppColor.backgroundColor,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: Get.isDarkMode
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark,
        child: SafeArea(
          child: EasyRefresh(
            header: const MaterialHeader(),
            onRefresh: UserService.instance.refreshProfile,
            child: ListView(
              padding: AppStyle.edgeInsetsA4,
              children: [
                AppStyle.vGap12,
                // 用户名、头像
                Obx(
                  () => Visibility(
                    visible: UserService.instance.logined.value,
                    child: ListTile(
                      leading: UserPhoto(
                        url: UserService.instance.userProfile.value?.cover,
                        size: 48,
                      ),
                      title: Text(
                        UserService.instance.userProfile.value?.nickname ?? "",
                        style: const TextStyle(height: 1.0),
                      ),
                      subtitle: Text(
                        UserService.instance.userProfile.value?.description ??
                            "",
                      ),
                      trailing: IconButton(
                        onPressed: controller.logout,
                        icon: const Icon(Remix.logout_box_r_line),
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => Visibility(
                    visible: !UserService.instance.logined.value,
                    child: ListTile(
                      leading: _buildPhoto(""),
                      title: const Text(
                        "未登录",
                        style: TextStyle(height: 1.0),
                      ),
                      subtitle: const Text(
                        "点击前往登录",
                      ),
                      trailing: const Icon(
                        Icons.chevron_right,
                        color: Colors.grey,
                      ),
                      onTap: controller.login,
                    ),
                  ),
                ),
                _buildCard(
                  context,
                  children: [
                    ListTile(
                      leading: const Icon(Remix.heart_line),
                      title: const Text("我的订阅"),
                      trailing: const Icon(
                        Icons.chevron_right,
                        color: Colors.grey,
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const Icon(Remix.history_line),
                      title: const Text("浏览记录"),
                      trailing: const Icon(
                        Icons.chevron_right,
                        color: Colors.grey,
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const Icon(Remix.chat_smile_2_line),
                      title: const Text("我的评论"),
                      trailing: const Icon(
                        Icons.chevron_right,
                        color: Colors.grey,
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const Icon(Remix.download_line),
                      title: const Text("下载管理"),
                      trailing: const Icon(
                        Icons.chevron_right,
                        color: Colors.grey,
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
                _buildCard(
                  context,
                  children: [
                    ListTile(
                      leading: Icon(
                          Get.isDarkMode ? Remix.moon_line : Remix.sun_line),
                      title: const Text("显示主题"),
                      trailing: const Icon(
                        Icons.chevron_right,
                        color: Colors.grey,
                      ),
                      onTap: controller.setTheme,
                    ),
                    ListTile(
                      leading: const Icon(Remix.settings_line),
                      title: const Text("更多设置"),
                      trailing: const Icon(
                        Icons.chevron_right,
                        color: Colors.grey,
                      ),
                      onTap: controller.setTheme,
                    ),
                  ],
                ),
                _buildCard(
                  context,
                  children: [
                    ListTile(
                      leading: const Icon(Remix.github_fill),
                      title: const Text("开源主页"),
                      trailing: const Icon(
                        Icons.chevron_right,
                        color: Colors.grey,
                      ),
                      onTap: () {
                        launchUrlString(
                          "https://github.com/xiaoyaocz/flutter_dmzj",
                          mode: LaunchMode.externalApplication,
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Remix.upload_2_line),
                      title: const Text("检查更新"),
                      trailing: const Icon(
                        Icons.chevron_right,
                        color: Colors.grey,
                      ),
                      onTap: controller.checkUpdate,
                    ),
                    ListTile(
                      leading: const Icon(Remix.information_line),
                      title: const Text("关于APP"),
                      trailing: const Icon(
                        Icons.chevron_right,
                        color: Colors.grey,
                      ),
                      onTap: controller.about,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPhoto(String? photo) {
    if (photo == null || photo.isEmpty) {
      return Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: Colors.lightBlue,
          borderRadius: BorderRadius.circular(56),
        ),
        child: const Icon(
          Remix.user_fill,
          color: Colors.white,
          size: 24,
        ),
      );
    }
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: Colors.lightBlue,
        borderRadius: BorderRadius.circular(56),
      ),
      child: NetImage(
        photo,
        width: 56,
        height: 56,
        borderRadius: 56,
      ),
    );
  }

  Widget _buildCard(BuildContext context, {required List<Widget> children}) {
    return Container(
      margin: AppStyle.edgeInsetsH12.copyWith(top: 12),
      child: Material(
        color: Theme.of(context).cardColor,
        borderRadius: AppStyle.radius8,
        child: Theme(
          data: Theme.of(context).copyWith(
            listTileTheme: ListTileThemeData(
              shape: RoundedRectangleBorder(borderRadius: AppStyle.radius8),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: children,
          ),
        ),
      ),
    );
  }
}
