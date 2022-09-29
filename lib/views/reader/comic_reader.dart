// ignore_for_file: must_be_immutable

import 'dart:convert';
import 'dart:typed_data';

import 'package:battery/battery.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:common_utils/common_utils.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_dmzj/app/api.dart';
import 'package:flutter_dmzj/app/app_setting.dart';
import 'package:flutter_dmzj/app/config_helper.dart';
import 'package:flutter_dmzj/app/user_helper.dart';
import 'package:flutter_dmzj/app/user_info.dart';
import 'package:flutter_dmzj/app/utils.dart';
import 'package:flutter_dmzj/models/comic/comic_chapter_view_point.dart';
import 'package:flutter_dmzj/models/comic/comic_web_chapter_detail.dart';
import 'package:flutter_dmzj/protobuf/comic/detail_response.pb.dart';
import 'package:flutter_dmzj/sql/comic_history.dart';
import 'package:flutter_dmzj/views/reader/comic_tc.dart';
import 'package:flutter_dmzj/widgets/comic_view.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:wakelock/wakelock.dart';

class ComicReaderPage extends StatefulWidget {
  final int comicId;
  final List<ComicDetailChapterInfoResponse> chapters;
  final ComicDetailChapterInfoResponse item;
  final String comicTitle;
  bool subscribe;

  ComicReaderPage(
      this.comicId, this.comicTitle, this.chapters, this.item, this.subscribe,
      {Key key})
      : super(key: key);

  @override
  _ComicReaderPageState createState() => _ComicReaderPageState();
}

class _ComicReaderPageState extends State<ComicReaderPage> {
  ComicDetailChapterInfoResponse _currentItem;
  Battery _battery = Battery();
  Connectivity _connectivity = Connectivity();
  String _batteryStr = "-%";
  String _networkState = "";

  double _verSliderMax = 0;
  double _verSliderValue = 0;
  //double currentBrightness = 0;
  @override
  void initState() {
    super.initState();
    if (ConfigHelper.getComicShowStatusBar()) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    }

    setBrightness();
    _currentItem = widget.item;

    _connectivity.checkConnectivity().then((e) {
      var str = "";
      if (e == ConnectivityResult.mobile) {
        str = "移动网络";
      } else if (e == ConnectivityResult.wifi) {
        str = "WIFI";
      } else if (e == ConnectivityResult.none) {
        str = "无网络";
      } else {
        str = "未知网络";
      }
      setState(() {
        _networkState = str;
      });
    });
    _connectivity.onConnectivityChanged.listen((e) {
      var str = "";
      if (e == ConnectivityResult.mobile) {
        str = "移动网络";
      } else if (e == ConnectivityResult.wifi) {
        str = "WIFI";
      } else if (e == ConnectivityResult.none) {
        str = "无网络";
      } else {
        str = "未知网络";
      }
      setState(() {
        _networkState = str;
      });
    });
    _battery.batteryLevel.then((e) {
      setState(() {
        _batteryStr = e.toString() + "%";
      });
    });
    _battery.onBatteryStateChanged.listen((BatteryState state) async {
      var e = await _battery.batteryLevel;
      setState(() {
        _batteryStr = e.toString() + "%";
      });
    });

    _scrollController.addListener(() {
      var value = _scrollController.offset;
      if (value < 0) {
        value = 0;
      }
      if (value > _scrollController.position.maxScrollExtent) {
        value = _scrollController.position.maxScrollExtent;
      }
      setState(() {
        _verSliderMax = _scrollController.position.maxScrollExtent;
        _verSliderValue = value;
        _verticalValue = ((_scrollController.offset /
                        _scrollController.position.maxScrollExtent) *
                    100)
                .toInt()
                .toString() +
            "%";
      });
    });

    loadData();
  }

  void setBrightness() async {
    //亮度信息
    // if (!ConfigHelper.getComicSystemBrightness()) {
    //   currentBrightness = await ScreenBrightness.current;
    //   await ScreenBrightness.setScreenBrightness(
    //       ConfigHelper.getComicBrightness());
    // }
    if (ConfigHelper.getComicWakelock()) {
      await Wakelock.enable();
    }
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    Wakelock.disable();
    //ScreenBrightness.setScreenBrightness(currentBrightness);
    int page = 1;
    if (!ConfigHelper.getComicVertical() ?? false) {
      print(_selectIndex);
      page = _selectIndex;
      if (page > _detail.picnum) {
        page = _detail.picnum;
      }
    }

    ComicHistoryProvider.getItem(widget.comicId).then((historyItem) async {
      if (historyItem != null) {
        historyItem.chapter_id = _currentItem.chapterId;
        historyItem.page = page.toDouble();
        await ComicHistoryProvider.update(historyItem);
      } else {
        await ComicHistoryProvider.insert(ComicHistory(
            widget.comicId, _currentItem.chapterId, page.toDouble(), 1));
      }
      Utils.changHistory.fire(widget.comicId);
    });

    UserHelper.comicAddComicHistory(widget.comicId, _currentItem.chapterId,
        page: page);
    super.dispose();
  }

  bool _showControls = false;
  bool _showChapters = false;
  int _selectIndex = 1;
  String _verticalValue = "0%";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          !_loading
              ? Provider.of<AppSetting>(context).comicVerticalMode
                  ? createVerticalReader()
                  : createHorizontalReader()
              : Center(
                  child: CircularProgressIndicator(),
                ),
          Positioned(
            child: Provider.of<AppSetting>(context).comicReadShowstate
                ? Container(
                    padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                    color: Color.fromARGB(255, 34, 34, 34),
                    child: Text(
                      _loading
                          ? "${_currentItem.chapterTitle}  加载中 WIFI  100%电量"
                          : Provider.of<AppSetting>(context).comicVerticalMode
                              ? "${_currentItem.chapterTitle}  $_verticalValue  $_networkState  $_batteryStr电量"
                              : "${_currentItem.chapterTitle}  $_selectIndex/${_detail.page_url.length}  $_networkState  $_batteryStr 电量",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  )
                : Container(),
            bottom: 0,
            right: 0,
          ),
          Provider.of<AppSetting>(context).comicVerticalMode
              ? Positioned(child: Container())
              : Positioned(
                  left: 0,
                  width: 40,
                  height: MediaQuery.of(context).size.height,
                  child: InkWell(
                    onTap: () {
                      if (Provider.of<AppSetting>(context, listen: false)
                          .comicReadReverse) {
                        previousPage();
                      } else {
                        nextPage();
                      }
                    },
                    child: Container(),
                  ),
                ),
          Provider.of<AppSetting>(context).comicVerticalMode
              ? Positioned(child: Container())
              : Positioned(
                  right: 0,
                  width: 40,
                  height: MediaQuery.of(context).size.height,
                  child: InkWell(
                    onTap: () {
                      if (Provider.of<AppSetting>(context, listen: false)
                          .comicReadReverse) {
                        nextPage();
                      } else {
                        previousPage();
                      }
                    },
                    child: Container(),
                  ),
                ),

          //顶部
          AnimatedPositioned(
            duration: Duration(milliseconds: 200),
            width: MediaQuery.of(context).size.width,
            child: Container(
              padding: EdgeInsets.only(
                  top: Provider.of<AppSetting>(context).comicReadShowStatusBar
                      ? 0
                      : MediaQuery.of(context).padding.top),
              width: MediaQuery.of(context).size.width,
              child: Material(
                  color: Color.fromARGB(255, 34, 34, 34),
                  child: ListTile(
                    dense: true,
                    title: Text(
                      widget.comicTitle,
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      _currentItem.chapterTitle,
                      style: TextStyle(color: Colors.white),
                    ),
                    leading: BackButton(
                      color: Colors.white,
                    ),
                    trailing: IconButton(
                        icon: Icon(
                          Icons.share,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Share.share(
                              '${widget.comicTitle}-${_currentItem.chapterTitle}\r\nhttps://m.dmzj.com/view/${widget.comicId}/${_currentItem.chapterId}.html');
                        }),
                  )),
            ),
            top: _showControls ? 0 : -100,
            left: 0,
          ),
          //底部
          AnimatedPositioned(
            duration: Duration(milliseconds: 200),
            width: MediaQuery.of(context).size.width,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              width: MediaQuery.of(context).size.width,
              color: Color.fromARGB(255, 34, 34, 34),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      ButtonTheme(
                        minWidth: 10,
                        padding:
                            EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                        child: TextButton(
                          onPressed: previousChapter,
                          child: Text(
                            "上一话",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Expanded(
                        child: !_loading
                            ? Provider.of<AppSetting>(context).comicVerticalMode
                                ? Slider(
                                    value: _verSliderValue,
                                    max: _verSliderMax,
                                    onChanged: (e) {
                                      _scrollController.jumpTo(e);
                                    },
                                  )
                                : Slider(
                                    value: _selectIndex >= 1
                                        ? _selectIndex.toDouble()
                                        : 0,
                                    max: _detail.picnum.toDouble(),
                                    onChanged: (e) {
                                      setState(() {
                                        _selectIndex = e.toInt();
                                        _pageController
                                            .jumpToPage(e.toInt() + 1);
                                      });
                                    },
                                  )
                            : Text(
                                "加载中",
                                style: TextStyle(color: Colors.white),
                              ),
                      ),
                      ButtonTheme(
                        minWidth: 10,
                        padding:
                            EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                        child: TextButton(
                          onPressed: nextChapter,
                          child: Text(
                            "下一话",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Provider.of<AppUserInfo>(context).isLogin &&
                              widget.subscribe
                          ? createButton(
                              "已订阅",
                              Icons.favorite,
                              onTap: () async {
                                if (await UserHelper.comicSubscribe(
                                    widget.comicId,
                                    cancel: true)) {
                                  setState(() {
                                    widget.subscribe = false;
                                  });
                                }
                              },
                            )
                          : createButton(
                              "订阅",
                              Icons.favorite_border,
                              onTap: () async {
                                if (await UserHelper.comicSubscribe(
                                    widget.comicId)) {
                                  setState(() {
                                    widget.subscribe = true;
                                  });
                                }
                              },
                            ),
                      createButton("设置", Icons.settings, onTap: openSetting),
                      createButton(
                          _detail != null ? "吐槽(${_viewPoints.length})" : "吐槽",
                          Icons.chat_bubble_outline,
                          onTap: openTCPage),
                      createButton("章节", Icons.format_list_bulleted, onTap: () {
                        setState(() {
                          _showChapters = true;
                        });
                      }),
                    ],
                  )
                ],
              ),
            ),
            bottom: _showControls ? 0 : -140,
            left: 0,
          ),

          //右侧章节选择
          AnimatedPositioned(
            duration: Duration(milliseconds: 200),
            width: 200,
            child: Container(
                height: MediaQuery.of(context).size.height,
                color: Color.fromARGB(255, 24, 24, 24),
                padding: EdgeInsets.only(
                    top: Provider.of<AppSetting>(context).comicReadShowStatusBar
                        ? 0
                        : MediaQuery.of(context).padding.top),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          "目录(${widget.chapters.length})",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        )),
                    Expanded(
                      child: ListView(
                        children: widget.chapters
                            .map((f) => ListTile(
                                  dense: true,
                                  onTap: () async {
                                    if (f != _currentItem) {
                                      setState(() {
                                        _currentItem = f;
                                        _showChapters = false;
                                        _showControls = false;
                                      });

                                      await loadData();
                                    }
                                  },
                                  title: Text(
                                    f.chapterTitle,
                                    style: TextStyle(
                                        color: f == _currentItem
                                            ? Theme.of(context)
                                                .colorScheme
                                                .secondary
                                            : Colors.white),
                                  ),
                                  subtitle: Text(
                                    "更新于" +
                                        TimelineUtil.format(
                                          int.parse(f.updatetime.toString()) *
                                              1000,
                                          locale: 'zh',
                                        ),
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  ],
                )),
            top: 0,
            right: _showChapters ? 0 : -200,
          ),
        ],
      ),
    );
  }

  void nextPage() async {
    if (_pageController.page == 1) {
      previousChapter();
      setState(() {
        _selectIndex = _detail.page_url.length;
        _pageController = PreloadPageController(initialPage: _selectIndex + 1);
        print('_selectIndex:' + _selectIndex.toString());
        print('page:${_selectIndex + 1}');
      });
    } else {
      setState(() {
        int newPage;
        if (_pageController.page.toInt() > _selectIndex) {
          newPage = _pageController.page.toInt() - 1;
        } else {
          newPage = _selectIndex - 1;
        }
        _pageController.jumpToPage(newPage);
      });
    }
  }

  void previousPage() {
    if (_pageController.page > _detail.page_url.length) {
      nextChapter();
    } else {
      setState(() {
        _pageController.jumpToPage(_selectIndex + 1);
      });
    }
  }

  Widget createButton(String text, IconData icon, {Function onTap}) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              children: <Widget>[
                Icon(icon, color: Colors.white),
                SizedBox(
                  height: 4,
                ),
                Text(
                  text,
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 打开吐槽详情页
  void openTCPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => ComicTCPage(
                _viewPoints, widget.comicId, _currentItem.chapterId)));
  }

  PreloadPageController _pageController = PreloadPageController(initialPage: 1);
  //PageController _pageController = PageController(initialPage: 1);
  ScrollController _scrollController = ScrollController();

  Widget createHorizontalReader() {
    return InkWell(
      onTap: () {
        setState(() {
          if (_showChapters) {
            _showChapters = false;
            return;
          }
          _showControls = !_showControls;
        });
      },
      child: Container(
        color: Colors.black,
        child: ComicView.builder(
          reverse: Provider.of<AppSetting>(context).comicReadReverse,
          builder: (BuildContext context, int index) {
            if (index > 0 && index <= _detail.page_url.length) {
              return PhotoViewGalleryPageOptions(
                filterQuality: FilterQuality.high,
                imageProvider: CachedNetworkImageProvider(
                  _detail.page_url[index - 1],
                  headers: {"Referer": "http://www.dmzj.com/"},
                ),
                initialScale: PhotoViewComputedScale.contained,
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.covered * 4.1,
              );
            } else {
              return PhotoViewGalleryPageOptions.customChild(
                  child: getExtraPage(index));
            }
          },
          gaplessPlayback: true,
          itemCount: _detail.page_url.length + 3,
          loadingBuilder: (context, event) {
            return Center(
              child: CircularProgressIndicator(),
            );
          },
          loadFailedChild: Center(
            child: Text("出错啦"),
          ),
          pageController: _pageController,
          onPageChanged: (i) {
            if (i == _detail.page_url.length + 2) {
              nextChapter();
              return;
            }
            if (i == 0 && !_loading) {
              previousChapter();
              return;
            }
            if (i < _detail.page_url.length + 1) {
              setState(() {
                _selectIndex = i;
              });
            }
            print('_selectIndex:' + _selectIndex.toString());
            print('page:$i');
          },
        ),
      ),
    );
  }

  Widget getExtraPage(int index) {
    if (index == 0) {
      return Center(
        child: Text(
            widget.chapters.indexOf(_currentItem) == 0 ? "前面没有了" : "上一章",
            style: TextStyle(color: Colors.grey)),
      );
    }
    if (index == _detail.page_url.length + 1) {
      return createTucao(24);
    }
    if (index == _detail.page_url.length + 2) {
      return Center(
        child: Text(
            widget.chapters.indexOf(_currentItem) == widget.chapters.length - 1
                ? "后面没有了"
                : "下一章",
            style: TextStyle(color: Colors.grey)),
      );
    }
    return Center(
      child: Text("出错啦"),
    );
  }

  Widget createVerticalReader() {
    return InkWell(
      onTap: () {
        setState(() {
          if (_showChapters) {
            _showChapters = false;
            return;
          }
          _showControls = !_showControls;
        });
      },
      child: EasyRefresh(
        scrollController: _scrollController,
        onRefresh: () async {
          previousChapter();
        },
        onLoad: () async {
          nextChapter();
        },
        footer: MaterialFooter(enableInfiniteLoad: false),
        header: MaterialHeader(),
        child: ListView.builder(
            itemCount: _detail.page_url.length + 1,
            controller: _scrollController,
            itemBuilder: (ctx, i) {
              if (i == _detail.page_url.length) {
                return createTucao(24);
              } else {
                var f = _detail.page_url[i];
                return Container(
                  color: Colors.black,
                  padding: EdgeInsets.only(bottom: 0),
                  child: CachedNetworkImage(
                      imageUrl: f,
                      httpHeaders: {"Referer": "http://www.dmzj.com/"},
                      placeholder: (ctx, i) => Container(
                            height: 400,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                      filterQuality: FilterQuality.high),
                );
              }
            }),
      ),
    );
  }

  Widget createVerticalColumn() {
    var ls = _detail.page_url
        .map<Widget>(
          (f) => Padding(
            padding: EdgeInsets.only(bottom: 0),
            child: CachedNetworkImage(
                imageUrl: f,
                httpHeaders: {"Referer": "http://www.dmzj.com/"},
                placeholder: (ctx, i) => Container(
                      height: 100,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                filterQuality: FilterQuality.high),
          ),
        )
        .toList();
    ls.add(createTucao(24));
    return Column(
      children: ls,
    );
  }

  Widget createTucao(int count) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8),
            child: Text("本章吐槽",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white,
                )),
          ),
          Wrap(
            children: _viewPoints
                .take(count)
                .map<Widget>((f) => createTucaoItem(f))
                .toList(),
          ),
          SizedBox(height: 12),
          Center(
            child: OutlinedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white.withOpacity(0.6)),
                    ),
                  ),
                ),
                onPressed: openTCPage,
                child: Text(
                  "查看更多(${_viewPoints.length})",
                  style: TextStyle(color: Colors.white),
                )),
          )
        ],
      ),
    );
  }

  Widget createTucaoItem(ComicChapterViewPoint item) {
    return Padding(
      padding: EdgeInsets.all(4),
      child: InkWell(
        onTap: () async {
          var result = await UserHelper.comicLikeViewPoint(item.id);
          if (result) {
            setState(() {
              item.num++;
            });
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.withOpacity(0.4)),
              borderRadius: BorderRadius.circular(16)),
          child: Text(
            item.content,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  void openSetting() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Material(
          color: Color.fromARGB(255, 34, 34, 34),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // SwitchListTile(
                //     title: Text(
                //       "使用系统亮度",
                //       style: TextStyle(color: Colors.white),
                //     ),
                //     value:
                //         Provider.of<AppSetting>(context).comicSystemBrightness,
                //     onChanged: (e) {
                //       Provider.of<AppSetting>(context, listen: false)
                //           .changeComicSystemBrightness(e);
                //     }),
                // !Provider.of<AppSetting>(context).comicSystemBrightness
                //     ? Row(
                //         children: <Widget>[
                //           SizedBox(width: 12),
                //           Icon(
                //             Icons.brightness_2,
                //             color: Colors.white,
                //             size: 18,
                //           ),
                //           Expanded(
                //               child: Slider(
                //                   value: Provider.of<AppSetting>(context)
                //                       .comicBrightness,
                //                   max: 1,
                //                   min: 0.01,
                //                   onChanged: (e) {
                //                     //ScreenBrightness.setScreenBrightness(e);
                //                     Provider.of<AppSetting>(context,
                //                             listen: false)
                //                         .changeBrightness(e);
                //                   })),
                //           Icon(Icons.brightness_5,
                //               color: Colors.white, size: 18),
                //           SizedBox(width: 12),
                //         ],
                //       )
                //     : Container(),
                SwitchListTile(
                    title: Text(
                      "使用网页API",
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      "网页部分单行本不分页",
                      style: TextStyle(color: Colors.grey),
                    ),
                    value: Provider.of<AppSetting>(context).comicWebApi,
                    onChanged: (e) {
                      Provider.of<AppSetting>(context, listen: false)
                          .changeComicWebApi(e);
                      loadData();
                    }),
                SwitchListTile(
                    title: Text(
                      "竖向阅读",
                      style: TextStyle(color: Colors.white),
                    ),
                    value: Provider.of<AppSetting>(context).comicVerticalMode,
                    onChanged: (e) {
                      Provider.of<AppSetting>(context, listen: false)
                          .changeComicVertical(e);
                      //Navigator.pop(context);
                    }),
                !Provider.of<AppSetting>(context).comicVerticalMode
                    ? SwitchListTile(
                        title: Text(
                          "日漫模式",
                          style: TextStyle(color: Colors.white),
                        ),
                        value:
                            Provider.of<AppSetting>(context).comicReadReverse,
                        onChanged: (e) {
                          Provider.of<AppSetting>(context, listen: false)
                              .changeReadReverse(e);
                        })
                    : Container(),
                SwitchListTile(
                    title: Text(
                      "屏幕常亮",
                      style: TextStyle(color: Colors.white),
                    ),
                    value: Provider.of<AppSetting>(context).comicWakelock,
                    onChanged: (e) {
                      Wakelock.enable();
                      Provider.of<AppSetting>(context, listen: false)
                          .changeComicWakelock(e);
                    }),
                SwitchListTile(
                    title: Text(
                      "全屏阅读",
                      style: TextStyle(color: Colors.white),
                    ),
                    value:
                        Provider.of<AppSetting>(context).comicReadShowStatusBar,
                    onChanged: (e) {
                      Provider.of<AppSetting>(context, listen: false)
                          .changeComicReadShowStatusBar(e);
                      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
                          overlays: e ? [] : SystemUiOverlay.values);
                    }),
                SwitchListTile(
                    title: Text(
                      "显示状态信息",
                      style: TextStyle(color: Colors.white),
                    ),
                    value: Provider.of<AppSetting>(context).comicReadShowstate,
                    onChanged: (e) {
                      Provider.of<AppSetting>(context, listen: false)
                          .changeComicReadShowState(e);
                    }),
                // SwitchListTile(
                //     title: Text(
                //       "音量键翻页",
                //       style: TextStyle(color: Colors.white),
                //     ),
                //     value: false,
                //     onChanged: (e) => {})
              ],
            ),
          ),
        );
      },
    );
  }

  bool _loading = false;
  ComicWebChapterDetail _detail;
  DefaultCacheManager _cacheManager = DefaultCacheManager();
  Future loadData() async {
    try {
      if (_loading) {
        return;
      }
      setState(() {
        _loading = true;
      });
      var api = Api.comicChapterDetail(widget.comicId, _currentItem.chapterId);

      if (ConfigHelper.getComicWebApi()) {
        api = Api.comicWebChapterDetail(widget.comicId, _currentItem.chapterId);
      }
      Uint8List responseBody;
      try {
        var response = await http.get(Uri.parse(api));
        responseBody = response.bodyBytes;
      } catch (e) {
        var file = await _cacheManager.getFileFromCache(api);
        if (file != null) {
          responseBody = await file.file.readAsBytes();
        }
      }

      var responseStr = utf8.decode(responseBody);
      print('加密的漫画章节详情数据: $responseStr');
      var jsonMap = jsonDecode(responseStr);

      ComicWebChapterDetail detail = ComicWebChapterDetail.fromJson(jsonMap);
      var historyItem = await ComicHistoryProvider.getItem(widget.comicId);
      if (historyItem != null &&
          historyItem.chapter_id == _currentItem.chapterId) {
        var page = historyItem.page.toInt();
        if (page > detail.page_url.length) {
          page = detail.page_url.length;
        }
        _pageController = new PreloadPageController(initialPage: page);
        setState(() {
          _selectIndex = page;
        });
        // _pageController.=;
      } else {
        _pageController = new PreloadPageController(initialPage: 1);
        setState(() {
          _selectIndex = 1;
        });
      }

      setState(() {
        _detail = detail;
      });
      await _cacheManager.putFile(api, responseBody);
      await loadViewPoint();

      //ConfigHelper.setComicHistory(widget.comicId, _currentItem.chapter_id);
      await UserHelper.comicAddComicHistory(
          widget.comicId, _currentItem.chapterId);
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  List<ComicChapterViewPoint> _viewPoints = [];
  Future loadViewPoint() async {
    try {
      setState(() {
        _viewPoints = [];
      });
      var response = await http.get(Uri.parse(
          Api.comicChapterViewPoint(widget.comicId, _currentItem.chapterId)));

      List jsonMap = jsonDecode(response.body);
      List<ComicChapterViewPoint> ls =
          jsonMap.map((f) => ComicChapterViewPoint.fromJson(f)).toList();
      ls.sort((a, b) => b.num.compareTo(a.num));
      setState(() {
        _viewPoints = ls;
      });
    } catch (e) {
      print(e);
    }
  }

  void nextChapter() async {
    if (widget.chapters.indexOf(_currentItem) == widget.chapters.length - 1) {
      Fluttertoast.showToast(msg: '已经是最后一章了');
      return;
    }
    setState(() {
      _currentItem = widget.chapters[widget.chapters.indexOf(_currentItem) + 1];
    });
    await loadData();
  }

  void previousChapter() async {
    if (widget.chapters.indexOf(_currentItem) == 0) {
      Fluttertoast.showToast(msg: '已经是最前面一章了');
      return;
    }
    setState(() {
      _currentItem = widget.chapters[widget.chapters.indexOf(_currentItem) - 1];
    });
    await loadData();
  }
}
