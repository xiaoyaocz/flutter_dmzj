import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:battery/battery.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_dmzj/app/api.dart';
import 'package:flutter_dmzj/app/app_setting.dart';
import 'package:flutter_dmzj/app/config_helper.dart';
import 'package:flutter_dmzj/app/user_helper.dart';
import 'package:flutter_dmzj/app/user_info.dart';
import 'package:flutter_dmzj/app/utils.dart';
import 'package:flutter_dmzj/models/novel/novel_volume_item.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class NovelReaderPage extends StatefulWidget {
  int novel_id;
  String novel_title;
  List<NovelVolumeChapterItem> chapters;
  NovelVolumeChapterItem current_item;
  bool subscribe;
  NovelReaderPage(
      this.novel_id, this.novel_title, this.chapters, this.current_item,
      {this.subscribe, Key key})
      : super(key: key);

  @override
  _NovelReaderPageState createState() => _NovelReaderPageState();
}

class _NovelReaderPageState extends State<NovelReaderPage> {
   //EventBus settingEvent = EventBus();
  List<String> _page_contents = ["加载中"];
  NovelVolumeChapterItem _current_item;
   Battery _battery = Battery();
  Uint8List _contents;

  double _ver_slider_max = 0;
  double _ver_slider_value = 0;

  double _fontSize = 16.0;
  double _lineHeight = 1.5;
  String _battery_str = "-%";
  @override
  void initState() {
    super.initState();
    _current_item = widget.current_item;
    //全屏
    SystemChrome.setEnabledSystemUIOverlays([]);
    _battery.batteryLevel.then((e) {
      setState(() {
        _battery_str = e.toString() + "%";
      });
    });

    _battery.onBatteryStateChanged.listen((BatteryState state) async {
      var e = await _battery.batteryLevel;
      setState(() {
        _battery_str = e.toString() + "%";
      });
    });
    //刷新内容
    // settingEvent.on<double>().listen((e) async {
    //   await handelContent();
    // });

    // _controller.addListener((){
    //   print(_controller.offset);
    // });
     _controller_ver.addListener(() {
      var value = _controller_ver.offset;
      if (value < 0) {
        value = 0;
      }
      if (value > _controller_ver.position.maxScrollExtent) {
        value = _controller_ver.position.maxScrollExtent;
      }
      setState(() {
        _ver_slider_max = _controller_ver.position.maxScrollExtent;
        _ver_slider_value = value;
      });
    });

    loadData();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
     UserHelper.comicAddNovelHistory(
          widget.novel_id, _current_item.volume_id,_current_item.chapter_id);
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  bool _show_controls = false;
  bool _show_chapters = false;
  PageController _controller = PageController(initialPage: 1);
  ScrollController _controller_ver=ScrollController();
  int _index_page = 1;
  bool _isPicture = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppSetting
          .bgColors[Provider.of<AppSetting>(context).novel_read_theme],
      body: Stack(
        children: <Widget>[
          InkWell(
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              setState(() {
                if (_show_chapters) {
                  _show_chapters = false;
                  return;
                }
                _show_controls = !_show_controls;
              });
            },
            child: Provider.of<AppSetting>(context).novel_read_direction!=2? PageView.builder(
              scrollDirection:
                 Axis.horizontal,
              pageSnapping:
                  Provider.of<AppSetting>(context).novel_read_direction != 2,
              controller: _controller,
              itemCount: _page_contents.length + 2,
              reverse:
                  Provider.of<AppSetting>(context).novel_read_direction == 1,
              onPageChanged: (i) {
                if (i == _page_contents.length + 1 && !_loading) {
                  nextChapter();
                  return;
                }
                if (i == 0 && !_loading) {
                  previousChapter();
                  return;
                }
                if (i < _page_contents.length + 1) {
                  setState(() {
                    _index_page = i;
                  });
                }

                // setState(() {
                //   _index_page = i;
                // });
              },
              itemBuilder: (ctx, i) {
                if (i == 0) {
                  return Container(
                    child: Center(
                        child:
                            Text("上一章", style: TextStyle(color: Colors.grey))),
                  );
                }
                if (i == _page_contents.length + 1) {
                  return Container(
                    child: Center(
                        child:
                            Text("下一章", style: TextStyle(color: Colors.grey))),
                  );
                }

                var _widget = _isPicture
                    ? Container(
                        color: AppSetting.bgColors[
                            Provider.of<AppSetting>(context).novel_read_theme],
                        child: InkWell(
                          onDoubleTap: () {
                            Utils.showImageViewDialog(
                                context,
                                _page_contents.length == 0
                                    ? ""
                                    : _page_contents[i - 1]);
                          },
                          onTap: () {
                            setState(() {
                              if (_show_chapters) {
                                _show_chapters = false;
                                return;
                              }
                              _show_controls = !_show_controls;
                            });
                          },
                          child: Utils.createCacheImage(
                              _page_contents[i-1], 100, 100),
                        ),
                      )
                    : Container(
                        color: AppSetting.bgColors[
                            Provider.of<AppSetting>(context).novel_read_theme],
                        padding: EdgeInsets.fromLTRB(12, 12, 12, 24),
                        alignment: Alignment.topCenter,
                        child: Text(
                          _page_contents.length == 0
                              ? ""
                              : _page_contents[i - 1],
                          style: TextStyle(
                              fontSize: _fontSize,
                              height: _lineHeight,
                              color: AppSetting.fontColors[
                                  Provider.of<AppSetting>(context)
                                      .novel_read_theme]),
                        ),
                      );
                return _widget;
              },
            ):EasyRefresh(
              onRefresh: () async{
                previousChapter();
              },
              onLoad: ()async{
                nextChapter();
              },
              header: MaterialHeader(),
              footer: MaterialFooter(displacement: 80),
              child: SingleChildScrollView(
              controller: _controller_ver,
              child: _isPicture?
              Column(
                children: _page_contents.map((f)=>InkWell(
                          onDoubleTap: () {
                            Utils.showImageViewDialog(
                                context,
                               f);
                          },
                          onTap: () {
                            setState(() {
                              if (_show_chapters) {
                                _show_chapters = false;
                                return;
                              }
                              _show_controls = !_show_controls;
                            });
                          },
                          child: Utils.createCacheImage(
                              f, 100, 100),
                        )).toList(),
              ):
              Container(
                alignment: Alignment.topCenter,
                 constraints: BoxConstraints(
                   minHeight: MediaQuery.of(context).size.height,
                 ),
                 color: AppSetting.bgColors[
                            Provider.of<AppSetting>(context).novel_read_theme],
                        padding: EdgeInsets.fromLTRB(12, 12, 12, 24),
                child: Text(_page_contents.join(), style: TextStyle(
                              fontSize: _fontSize,
                              height: _lineHeight,
                              color: AppSetting.fontColors[
                                  Provider.of<AppSetting>(context)
                                      .novel_read_theme])),
              ),
            ),),
          ),
           Provider.of<AppSetting>(context).novel_read_direction==2
              ? Positioned(child: Container())
              : Positioned(
                  left: 0,
                  width: 40,
                  height: MediaQuery.of(context).size.height,
                  child: InkWell(
                    onTap: () {
                      if(Provider.of<AppSetting>(context,listen: false).novel_read_direction==1){
                        previousPage();
                      }else{
                        nextPage();
                      }
                    },
                    child: Container(),
                  ),
                ),
          Provider.of<AppSetting>(context).novel_read_direction==2
              ? Positioned(child: Container())
              : Positioned(
                  right: 0,
                  width: 40,
                  height: MediaQuery.of(context).size.height,
                  child: InkWell(
                    onTap: () {
                       if(Provider.of<AppSetting>(context,listen: false).novel_read_direction==1){
                        nextPage();
                      }else{
                        previousPage();
                      }

                    },
                    child: Container(),
                  ),
          ),


          Positioned(
            bottom: 8,
            right: 12,
            child: Text(
              Provider.of<AppSetting>(context).novel_read_direction==2? 
                  "":
                  "${_index_page}/${_page_contents.length} $_battery_str电量",
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),
          //加载
          Positioned(
            top: 80,
            width: MediaQuery.of(context).size.width,
            child: _loading
                ? Container(
                    width: double.infinity,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Container(),
          ),

          //顶部
          AnimatedPositioned(
            duration: Duration(milliseconds: 200),
            width: MediaQuery.of(context).size.width,
            child: Container(
              padding: EdgeInsets.only(
                  top: Provider.of<AppSetting>(context).comic_read_showStatusBar
                      ? 0
                      : MediaQuery.of(context).padding.top),
              width: MediaQuery.of(context).size.width,
              child: Material(
                  color: Color.fromARGB(255, 34, 34, 34),
                  child: ListTile(
                    dense: true,
                    title: Text(
                      widget.novel_title,
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      _current_item.volume_name.trim() +
                          " · " +
                          _current_item.chapter_name.trim(),
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
                        onPressed: () {}),
                  )),
            ),
            top: _show_controls ? 0 : -100,
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
                        child: FlatButton(
                          onPressed: previousChapter,
                          child: Text(
                            "上一话",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Expanded(
                        child: !_loading
                            ? Provider.of<AppSetting>(context)
                                    .novel_read_direction==2
                                ? Slider(
                                    value: _ver_slider_value,
                                    max: _ver_slider_max,
                                    onChanged: (e) {
                                      _controller_ver.jumpTo(e);
                                    },
                                  ):Slider(
                                value: _index_page >= 1
                                    ? _index_page - 1.toDouble()
                                    : 0,
                                max: _page_contents.length - 1.toDouble(),
                                onChanged: (e) {
                                  setState(() {
                                    _index_page = e.toInt() + 1;
                                    _controller.jumpToPage(e.toInt()+1);
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
                        child: FlatButton(
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
                                if (await UserHelper.novelSubscribe(
                                    widget.novel_id,
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
                                if (await UserHelper.novelSubscribe(
                                    widget.novel_id)) {
                                  setState(() {
                                    widget.subscribe = true;
                                  });
                                }
                              },
                            ),
                      createButton("设置", Icons.settings, onTap: openSetting),
                      createButton("章节", Icons.format_list_bulleted, onTap: () {
                        setState(() {
                          _show_chapters = true;
                        });
                      }),
                    ],
                  ),
                  SizedBox(height: 36)
                ],
              ),
            ),
            bottom: _show_controls ? 0 : -180,
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
                    top: Provider.of<AppSetting>(context)
                            .comic_read_showStatusBar
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
                                    if (f != _current_item) {
                                      setState(() {
                                        _current_item = f;
                                        _show_chapters = false;
                                        _show_controls = false;
                                      });

                                      await loadData();
                                    }
                                  },
                                  title: Text(
                                    f.chapter_name,
                                    style: TextStyle(
                                        color: f == _current_item
                                            ? Theme.of(context).accentColor
                                            : Colors.white),
                                  ),
                                  subtitle: Text(
                                    f.volume_name,
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  ],
                )),
            top: 0,
            right: _show_chapters ? 0 : -200,
          ),
        ],
      ),
    );
  }

   void nextPage() {
    if (_controller.page == 1) {
      previousChapter();
    } else {
      setState(() {
        _controller.jumpToPage(_index_page - 1);
      });
    }
  }

  void previousPage() {
    if (_controller.page > _page_contents.length) {
      nextChapter();
    } else {
      setState(() {
        _controller.jumpToPage(_index_page + 1);
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

  void openSetting() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Color.fromARGB(255, 34, 34, 34),
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: 80,
                    child: Text(
                      "字号",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Expanded(
                    child: createOutlineButton("小", onPressed: () async{
                      var size = Provider.of<AppSetting>(context, listen: false)
                          .novel_font_size;
                      if (size == 10) {
                        Fluttertoast.showToast(msg: '不能再小了');
                        return;
                      }
                      if (size == 30) {
                        Fluttertoast.showToast(msg: '不能再大了');
                        return;
                      }
                      Provider.of<AppSetting>(context, listen: false)
                          .changeNovelFontSize(size - 1);
                       await handelContent();
                    }),
                  ),
                  SizedBox(
                    width: 24,
                  ),
                  Expanded(
                    child: createOutlineButton("大", onPressed: () async{
                      var size = Provider.of<AppSetting>(context, listen: false)
                          .novel_font_size;
                      if (size == 10) {
                        Fluttertoast.showToast(msg: '不能再小了');
                        return;
                      }
                      if (size == 30) {
                        Fluttertoast.showToast(msg: '不能再大了');
                        return;
                      }
                      Provider.of<AppSetting>(context, listen: false)
                          .changeNovelFontSize(size + 1);
                      await handelContent();
                    }),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: 80,
                    child: Text(
                      "行距",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Expanded(
                    child: createOutlineButton("减少", onPressed: () async{
                      var height =
                          Provider.of<AppSetting>(context, listen: false)
                              .novel_line_height;
                      if (height == 0.8) {
                        Fluttertoast.showToast(msg: '不能再减少了');
                        return;
                      }
                      Provider.of<AppSetting>(context, listen: false)
                          .changeNovelLineHeight(height - 0.1);
                      await handelContent();
                    }),
                  ),
                  SizedBox(
                    width: 24,
                  ),
                  Expanded(
                    child: createOutlineButton("增加", onPressed: () async{
                      var height =
                          Provider.of<AppSetting>(context, listen: false)
                              .novel_line_height;
                      if (height == 2.0) {
                        Fluttertoast.showToast(msg: '不能再增加了');
                        return;
                      }
                      Provider.of<AppSetting>(context, listen: false)
                          .changeNovelLineHeight(height + 0.1);
                     await handelContent();
                    }),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: 80,
                    child: Text(
                      "方向",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Expanded(
                    child: createOutlineButton("左右",
                        borderColor: Provider.of<AppSetting>(context)
                                    .novel_read_direction ==
                                0
                            ? Colors.blue
                            : null, onPressed: () {
                      Provider.of<AppSetting>(context, listen: false)
                          .changeNovelReadDirection(0);
                    }),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: createOutlineButton("右左",
                        borderColor: Provider.of<AppSetting>(context)
                                    .novel_read_direction ==
                                1
                            ? Colors.blue
                            : null, onPressed: () {
                      Provider.of<AppSetting>(context, listen: false)
                          .changeNovelReadDirection(1);
                    }),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: createOutlineButton("上下",
                        borderColor: Provider.of<AppSetting>(context)
                                    .novel_read_direction ==
                                2
                            ? Colors.blue
                            : null, onPressed: () {
                      Provider.of<AppSetting>(context, listen: false)
                          .changeNovelReadDirection(2);
                    }),
                  )
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: 80,
                    child: Text(
                      "主题",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Expanded(
                    child: createOutlineButtonColor(AppSetting.bgColors[0],
                        borderColor:
                            Provider.of<AppSetting>(context).novel_read_theme ==
                                    0
                                ? Colors.blue
                                : null, onPressed: () {
                      Provider.of<AppSetting>(context, listen: false)
                          .changeNovelReadTheme(0);
                    }),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: createOutlineButtonColor(AppSetting.bgColors[1],
                        borderColor:
                            Provider.of<AppSetting>(context).novel_read_theme ==
                                    1
                                ? Colors.blue
                                : null, onPressed: () {
                      Provider.of<AppSetting>(context, listen: false)
                          .changeNovelReadTheme(1);
                    }),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: createOutlineButtonColor(AppSetting.bgColors[2],
                        borderColor:
                            Provider.of<AppSetting>(context).novel_read_theme ==
                                    2
                                ? Colors.blue
                                : null, onPressed: () {
                      Provider.of<AppSetting>(context, listen: false)
                          .changeNovelReadTheme(2);
                    }),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: createOutlineButtonColor(AppSetting.bgColors[3],
                        borderColor:
                            Provider.of<AppSetting>(context).novel_read_theme ==
                                    3
                                ? Colors.blue
                                : null, onPressed: () {
                      Provider.of<AppSetting>(context, listen: false)
                          .changeNovelReadTheme(3);
                    }),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Widget createOutlineButton(String text,
      {Function onPressed, Color borderColor}) {
    if (borderColor == null) {
      borderColor = Colors.grey.withOpacity(0.6);
    }
    return OutlineButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      textColor: Theme.of(context).accentColor,
      borderSide: BorderSide(color: borderColor),
      child: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
      onPressed: onPressed,
    );
  }

  Widget createOutlineButtonColor(Color color,
      {Function onPressed, Color borderColor}) {
    if (borderColor == null) {
      borderColor = Colors.grey.withOpacity(0.6);
    }
    return InkWell(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: borderColor),
          color: color,
        ),
        height: 32,
      ),
      onTap: onPressed,
    );
  }

  bool _loading = false;
  DefaultCacheManager _cacheManager = DefaultCacheManager();
  Future loadData() async {
    try {
      if (_loading) {
        return;
      }
      setState(() {
        _loading = true;

        _page_contents = ["加载中"];
        try {
           _controller.jumpToPage(1);
        } catch (e) {
        }
      });

      //检查缓存
      var url = Api.novelRead(
          widget.novel_id, _current_item.volume_id, _current_item.chapter_id);
      var file = await _cacheManager.getFileFromCache(url);
      if (file == null) {
        file = await _cacheManager.downloadFile(url);
      }

      //var response = await http.get(url);
      var bodyBytes = await file.file.readAsBytes();
      if (String.fromCharCodes(bodyBytes.take(200))
          .contains(RegExp('<img.*?>'))) {
        var str = Utf8Decoder().convert(bodyBytes);
        List<String> imgs = [];
        for (var item
            in RegExp(r'<img.*?src=[' '""](.*?)[' '""].*?>').allMatches(str)) {
          //print(item.group(1));
          imgs.add(item.group(1));
        }
        _contents = Uint8List(0);
        setState(() {
          _isPicture = true;
          _page_contents = imgs;
        });
      } else {
        setState(() {
          _isPicture = false;
        });
        _contents = bodyBytes;

        await handelContent();
      }

      ConfigHelper.setNovelHistory(widget.novel_id, _current_item.chapter_id);
      UserHelper.comicAddNovelHistory(
          widget.novel_id, _current_item.volume_id,_current_item.chapter_id);
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  Future handelContent() async {
    if (_isPicture) {
      return;
    }
    var i = DateTime.now().millisecondsSinceEpoch;
    var width = window.physicalSize.width / window.devicePixelRatio;

    var height = window.physicalSize.height / window.devicePixelRatio;
    var par = ComputeParameter(_contents, width, height,
        ConfigHelper.getNovelFontSize(), ConfigHelper.getNovelLineHeight());
    var ls = await compute(computeContent, par);

    setState(() {
      _page_contents = ls;
      _fontSize = ConfigHelper.getNovelFontSize();
      _lineHeight = ConfigHelper.getNovelLineHeight();
    });
    print(DateTime.now().millisecondsSinceEpoch - i);
  }

  static List<String> computeContent(ComputeParameter par) {
    var width = par.width;

    var height = par.height;
    var _content = HtmlUnescape()
        .convert(Utf8Decoder()
            .convert(par.content)
            .replaceAll('\r\n', '\n')
            .replaceAll("<br/>", "\n")
            .replaceAll('<br />', "\n")
            .replaceAll('\n\n\n', "\n")
            .replaceAll('\n', "\n  "))
        .replaceAll("\n  \n", "\n");
    var content = toSBC(_content);

    //计算每行字数
    var maxNum = (width - 12 * 2) / par.fontSize;
    var maxNum_int = maxNum.toInt();

    //对每行字数进行添加换行符
    var result = '';
    for (var item in content.split('\n')) {
      for (var i = 0; i < item.length; i++) {
        if ((i + 1) % maxNum_int == 0 && i != item.length - 1) {
          result += item[i] + "\n";
        } else {
          result += item[i];
        }
      }
      result += '\n';
    }
    //result = result.replaceAll('\n\n' , '\n');
    //计算每页行数
    double pageLineNum_double =
        (height - (12 * 4)) / (par.fontSize * par.lineHeight);
    //int pageLineNum=  ((height - 12 * 2) %(_fontSize * _lineHeight)==0)? pageLineNum_double.truncate():pageLineNum_double.truncate()-1;
    int pageLineNum = pageLineNum_double.floor();
    print(pageLineNum_double);
    print(pageLineNum);
    //计算页数
    var lines = result.split("\n");
    var maxPages = (lines.length / pageLineNum).ceil();
    //处理出每页显示的文本
    List<String> ls = [];
    for (var i = 0; i < maxPages; i++) {
      var re = "";
      for (var item in lines.skip(i * pageLineNum).take(pageLineNum)) {
        re += item + "\n";
      }
      ls.add(re);
    }
    return ls;
  }

  // 半角转全角：
  static String toSBC(String input) {
    List<int> value = [];
    var array = input.codeUnits;
    for (int i = 0; i < array.length; i++) {
      if (array[i] == 32) {
        value.add(12288);
      } else if (array[i] > 32 && array[i] <= 126) {
        value.add((array[i] + 65248));
        //value.add(array[i]);
      } else {
        value.add(array[i]);
      }
    }
    return String.fromCharCodes(value);
  }

  void nextChapter() async {
    if (widget.chapters.indexOf(_current_item) == widget.chapters.length - 1) {
      Fluttertoast.showToast(msg: '已经是最后一章了');
      return;
    }
    setState(() {
      _current_item =
          widget.chapters[widget.chapters.indexOf(_current_item) + 1];
    });
    await loadData();
  }

  void previousChapter() async {
    if (widget.chapters.indexOf(_current_item) == 0) {
      Fluttertoast.showToast(msg: '已经是最前面一章了');
      return;
    }
    setState(() {
      _current_item =
          widget.chapters[widget.chapters.indexOf(_current_item) - 1];
    });
    await loadData();
  }
}

class ComputeParameter {
  Uint8List content;
  double width;
  double height;
  double fontSize;
  double lineHeight;
  ComputeParameter(
      this.content, this.width, this.height, this.fontSize, this.lineHeight);
}
