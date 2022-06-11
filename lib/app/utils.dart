import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_dmzj/app/config_helper.dart';
import 'package:flutter_dmzj/models/comic/comic_detail_model.dart';
import 'package:flutter_dmzj/models/novel/novel_volume_item.dart';
import 'package:flutter_dmzj/models/version_info.dart';
import 'package:flutter_dmzj/protobuf/comic/detail_response.pb.dart';
import 'package:flutter_dmzj/protobuf/novel/novel_chapter_response.pb.dart';
import 'package:flutter_dmzj/views/comic/comic_author.dart';
import 'package:flutter_dmzj/views/comic/comic_category_detail.dart';
import 'package:flutter_dmzj/views/comic/comic_detail.dart';
import 'package:flutter_dmzj/views/comic/comic_detail_v2.dart';
import 'package:flutter_dmzj/views/comic/comic_special_detail.dart';
import 'package:flutter_dmzj/views/news/news_detail.dart';
import 'package:flutter_dmzj/views/novel/novel_category_detail.dart';
import 'package:flutter_dmzj/views/novel/novel_detail.dart';
import 'package:flutter_dmzj/views/other/comment_widget.dart';
import 'package:flutter_dmzj/views/other/web_page.dart';
import 'package:flutter_dmzj/views/reader/comic_reader.dart';
import 'package:flutter_dmzj/views/reader/novel_reader.dart';
import 'package:flutter_dmzj/views/user/my_comment_page.dart';
import 'package:flutter_dmzj/views/user/user_detail.dart';
import 'package:flutter_dmzj/views/user/user_history.dart';
import 'package:flutter_dmzj/views/user/user_subscribe.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:package_info/package_info.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:http/http.dart' as http;

class Utils {
  static EventBus changeComicHomeTabIndex = EventBus();
  static EventBus changeNovelHomeTabIndex = EventBus();
  static EventBus changHistory = EventBus();
  static EventBus changeHideBanner = EventBus();
  static void showSnackbarWithAction(
      BuildContext context, String content, String action, Function onPressed) {
    final snackBar = new SnackBar(
        content: new Text(content),
        action: new SnackBarAction(label: action, onPressed: onPressed));

    Scaffold.of(context).showSnackBar(snackBar);
  }

  static void showSnackbar(BuildContext context, String content,
      {Duration duration}) {
    final snackBar = new SnackBar(
      content: new Text(content),
      duration: duration,
    );

    Scaffold.of(context).showSnackBar(snackBar);
  }

  static bool hideBanner = true;
  static Future<VersionInfo> checkVersion() async {
    try {
      var newVersion = await http.get(Uri.parse(
          "https://raw.staticdn.net/xiaoyaocz/dmzj_flutter/master/new_version.json?ts=" +
              DateTime.now().millisecondsSinceEpoch.toString()));
      var verInfo =
          VersionInfo.fromJson(jsonDecode(utf8.decode(newVersion.bodyBytes)));
      hideBanner = verInfo.hide_banner;
      changeHideBanner.fire(hideBanner);
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      if (int.parse(packageInfo.buildNumber) <
          int.parse(verInfo.version_code)) {
        return verInfo;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<bool> showAlertDialogAsync(
      BuildContext context, Widget title, Widget content) async {
    bool result = false;
    await showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: title,
              content: content,
              actions: <Widget>[
                new FlatButton(
                  child: new Text("确定"),
                  onPressed: () {
                    result = true;
                    Navigator.of(context).pop();
                  },
                ),
                new FlatButton(
                  child: new Text("取消"),
                  onPressed: () {
                    result = false;
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
    return result;
  }

  static void showImageViewDialog(BuildContext context, String image) {
    showDialog(
        context: context,
        builder: (_) {
          return Stack(
            children: <Widget>[
              Material(
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                      child: PhotoView(
                    loadingBuilder: (context, event) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                    imageProvider: CachedNetworkImageProvider(image,
                        headers: {"Referer": "http://www.dmzj.com/"}),
                  )),
                ),
              ),
              Positioned(
                bottom: 12,
                right: 12,
                child: FlatButton(
                  onPressed: () async {
                    try {
                      var file = DefaultCacheManager().getFileFromMemory(image);
                      var byes = (await file).file.readAsBytesSync();
                      var dir = await getApplicationDocumentsDirectory();
                      await File(dir.path +
                              "/" +
                              DateTime.now().millisecondsSinceEpoch.toString() +
                              ".jpg")
                          .writeAsBytes(byes, mode: FileMode.write);
                      Fluttertoast.showToast(msg: '保存成功');
                    } catch (e) {
                      Fluttertoast.showToast(msg: '保存失败');
                    }
                  },
                  textColor: Colors.white,
                  child: Text("保存"),
                ),
              ),
            ],
          );
        });
  }

  static Widget createCacheImage(String url, double width, double height,
      {BoxFit fit = BoxFit.fitWidth}) {
    if (url.contains("dmzj1.com")) {
      url = url.replaceAll("dmzj1.com", "muwai.com");
    }
    return CachedNetworkImage(
      imageUrl: url,
      fit: fit,
      httpHeaders: {"Referer": "http://www.dmzj.com/"},
      placeholder: (context, url) => AspectRatio(
        aspectRatio: width / height,
        child: Container(
          width: width,
          height: height,
          child: Icon(Icons.photo, color: Colors.grey),
        ),
      ),
      errorWidget: (context, url, error) => AspectRatio(
        aspectRatio: width / height,
        child: Container(
          width: width,
          height: height,
          child: Icon(
            Icons.error,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  static CachedNetworkImageProvider createCachedImageProvider(String url) {
    if (url.contains("dmzj1.com")) {
      url = url.replaceAll("dmzj1.com", "muwai.com");
    }
    return CachedNetworkImageProvider(
      url,
      headers: {"Referer": "http://www.dmzj.com/"},
    );
  }

  /// 打开页面
  /// [type] 1=漫画，2=小说，5=专题，6=网页，7=新闻，8=漫画作者，10=游戏，11=类目详情，12=个人中心
  static void openPage(BuildContext context, int id, int type,
      {String url, String title}) {
    if (id == null) {
      Fluttertoast.showToast(msg: '无法打开此内容');
      return;
    }
    switch (type) {
      case 1:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => ComicDetailPage(id)));
        break;
      case 2:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => NovelDetailPage(id)));
        print("打开小说" + id.toString());
        break;
      case 5:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => ComicSpecialDetailPage(id)));
        print("打开专题" + id.toString());
        break;
      case 6:
        print("打开网页" + id.toString());
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return WebViewPage(url);
        }));
        break;
      case 7:
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return NewsDetailPage(id, url, title);
        }));
        break;
      case 8:
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ComicAuthorPage(id);
        }));
        break;
      case 10:
        print("打开游戏" + id.toString());
        break;
      case 11:
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ComicCategoryDetailPage(id, title);
        }));
        break;
      case 12:
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return UserDetailPage(id);
        }));
        break;
      case 13:
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return NovelCategoryDetailPage(id, title);
        }));
        break;
      default:
        break;
    }
  }

  static void openCommentPage(
      BuildContext context, int id, int type, String title) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => Scaffold(
                  appBar: AppBar(
                    title: Text(title),
                  ),
                  body: CommentWidget(type, id),
                )));
  }

  static void openSubscribePage(BuildContext context, {int index = 0}) {
    if (!ConfigHelper.getUserIsLogined() ?? false) {
      Fluttertoast.showToast(msg: '没有登录');
      return;
    }
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) =>
                UserSubscribePage(index: index)));
  }

  static void openHistoryPage(BuildContext context) {
    if (!ConfigHelper.getUserIsLogined() ?? false) {
      Fluttertoast.showToast(msg: '没有登录');
      return;
    }
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => UserHistoryPage()));
  }

  static void openMyCommentPage(BuildContext context) {
    if (!ConfigHelper.getUserIsLogined() ?? false) {
      Fluttertoast.showToast(msg: '没有登录');
      return;
    }
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => MyCommentPage()));
  }

  static Future openComicReader(
      BuildContext context,
      int comicId,
      String comicTitle,
      bool isSubscribe,
      List<ComicDetailChapterInfoResponse> chapters,
      ComicDetailChapterInfoResponse item) async {
    var ls = chapters.toList();
    ls.sort((a, b) => a.chapterOrder.compareTo(b.chapterOrder));
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) =>
            ComicReaderPage(comicId, comicTitle, ls, item, isSubscribe),
      ),
    );
  }

  static Future openNovelReader(
      BuildContext context,
      int novelId,
      List<NovelChapterVolumeResponse> chapters,
      NovelChapterItemResponse chapterItem,
      {String novelTitle,
      bool isSubscribe}) async {
    // var ls = chapters.toList();
    NovelVolumeChapterItem currentItem = NovelVolumeChapterItem(
      chapter_id: chapterItem.chapterId,
      chapter_name: chapterItem.chapterName,
      chapter_order: chapterItem.chapterOrder,
    );
    List<NovelVolumeChapterItem> items = [];

    for (var item in chapters) {
      for (var item2 in item.chapters) {
        if (item2.chapterId == currentItem.chapter_id) {
          currentItem.volume_id = item.volumeId;
          currentItem.volume_name = item.volumeName;
          items.add(currentItem);
        } else {
          var chapter = NovelVolumeChapterItem(
              chapter_id: item2.chapterId,
              chapter_name: item2.chapterName,
              chapter_order: item2.chapterOrder);
          chapter.volume_id = item.volumeId;
          chapter.volume_name = item.volumeName;
          items.add(chapter);
        }
      }
    }
    // ls.sort((a, b) => a.chapter_order.compareTo(b.chapter_order));
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => NovelReaderPage(
          novelId,
          novelTitle,
          items,
          currentItem,
          subscribe: isSubscribe,
        ),
      ),
    );
  }
}
