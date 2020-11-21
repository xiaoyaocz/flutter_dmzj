import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_dmzj/app/utils.dart';
import 'package:flutter_dmzj/models/comic/comic_detail_model.dart';
import 'package:flutter_dmzj/views/download/downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ComicDownloadPage extends StatefulWidget {
  final ComicDetail detail;
  ComicDownloadPage(this.detail, {Key key}) : super(key: key);

  @override
  _ComicDownloadPageState createState() => _ComicDownloadPageState();
}

class _ComicDownloadPageState extends State<ComicDownloadPage> {
  bool _selectAll = false;
  List<ComicDetailChapterItem> _ls = [];
  DefaultCacheManager _cacheManager = DefaultCacheManager();
  ComicDownloader _downloader;
  List<bool> downloadingState = [];
  List<bool> deleteState = [];
  double _progress;
  bool _deleteMode = false;

  @override
  Future<void> initState() {
    super.initState();
    _ls = [];
    for (var item in widget.detail.chapters) {
      for (var item2 in item.data) {
        item2.volume_name = item.title;
        downloadingState.add(false);
        deleteState.add(false);
      }
      _ls.addAll(item.data);
    }
    _downloader = ComicDownloader(widget.detail.id);
    _downloader.progressBus.on<double>().listen((event) {
      setState(() {
        _progress = event;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('选择章节'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              setState(() {
                _deleteMode = !_deleteMode;
              });
            },
          ),
          IconButton(
              icon: Icon(Icons.select_all),
              onPressed: () {
                _selectAll = !_selectAll;
                if (_deleteMode) {
                  for (int i = 0; i < _ls.length; i++) {
                    if (_ls[i].downloaded) {
                      setState(() {
                        deleteState[i] = _selectAll;
                      });
                    }
                  }
                } else {
                  for (var item in _ls.where((x) => !x.downloaded)) {
                    setState(() {
                      item.selected = _selectAll;
                    });
                  }
                }
              })
        ],
      ),
      body: ListView.builder(
        itemCount: _ls.length,
        itemBuilder: (ctx, i) => CheckboxListTile(
          value: _deleteMode ? deleteState[i] : _ls[i].selected,
          title: Text(
            _ls[i].volume_name + ' - ' + _ls[i].chapter_title,
            style: TextStyle(
                color: _ls[i].downloaded
                    ? Colors.grey
                    : Theme.of(context).textTheme.bodyText1.color),
          ),
          subtitle: downloadingState[i]
              ? LinearProgressIndicator(
                  value: _progress,
                )
              : Text(_ls[i].downloaded ? '已下载' : '未下载'),
          onChanged: (e) {
            setState(() {
              if (_deleteMode) {
                if (_ls[i].downloaded) {
                  deleteState[i] = e;
                }
              } else {
                if (!_ls[i].downloaded) {
                  _ls[i].selected = e;
                }
              }
            });
          },
        ),
      ),
      floatingActionButton: AnimatedCrossFade(
        firstChild: FloatingActionButton(
          heroTag: 'ComicDownload',
          child: Icon(Icons.file_download),
          onPressed: () async {
            Fluttertoast.showToast(msg: '添加到列队');
            //保存漫画detail完整信息
            //创建一个下载器传入_ls，自动判断是否下载
            //comic-version(连载)-chapter
            //在文件夹中下载
            //或者使用缓存器直接缓存
            for (int i = 0; i < _ls.length; i++) {
              if (_ls[i].selected) {
                setState(() {
                  downloadingState[i] = true;
                });
                await _downloader.startDownload(_ls[i]).whenComplete(() {
                  setState(() {
                    _ls[i].downloaded = true;
                    _ls[i].selected = false;
                    downloadingState[i] = false;
                  });
                });
              }
            }
          },
        ),
        secondChild: FloatingActionButton(
          heroTag: 'ComicDelete',
          backgroundColor: Theme.of(context).errorColor,
          child: Icon(
            Icons.delete,
          ),
          onPressed: () async {
            if (await Utils.showAlertDialogAsync(
              context,
              Text('删除下载'),
              Text('确认删除这些项吗'),
            )) {
              int success = 0;
              int error = 0;
              for (int i = 0; i < _ls.length; i++) {
                if (deleteState[i]) {
                  if (await _downloader.delete(_ls[i]) == 0) {
                    success += 1;
                    setState(() {
                      _ls[i].downloaded = false;
                      deleteState[i] = false;
                    });
                  } else
                    error += 1;
                }
              }
              Fluttertoast.showToast(msg: '成功 $success 个, 失败 $error 个');
            }
          },
        ),
        crossFadeState:
            _deleteMode ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        duration: Duration(milliseconds: 200),
      ),
    );
  }
}
