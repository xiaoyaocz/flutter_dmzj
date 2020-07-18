import 'package:flutter/material.dart';
import 'package:flutter_dmzj/models/comic/comic_detail_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ComicDownloadPage extends StatefulWidget {
  ComicDetail detail;
  ComicDownloadPage(this.detail, {Key key}) : super(key: key);

  @override
  _ComicDownloadPageState createState() => _ComicDownloadPageState();
}

class _ComicDownloadPageState extends State<ComicDownloadPage> {
  bool _selectAll = false;
  List<ComicDetailChapterItem> _ls = [];

  @override
  void initState() {
    super.initState();
    _ls = [];
    for (var item in widget.detail.chapters) {
      for (var item2 in item.data) {
        item2.volume_name = item.title;
      }
      _ls.addAll(item.data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('选择章节'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.select_all),
              onPressed: () {
                _selectAll = !_selectAll;
                for (var item in _ls.where((x) => !x.downloaded)) {
                  setState(() {
                    item.selected = _selectAll;
                  });
                }
              })
        ],
      ),
      body: ListView.builder(
        itemCount: _ls.length,
        itemBuilder: (ctx, i) => CheckboxListTile(
          value: _ls[i].selected,
          title: Text(
            _ls[i].volume_name + ' - ' + _ls[i].chapter_title,
            style: TextStyle(
                color: _ls[i].downloaded
                    ? Colors.grey
                    : Theme.of(context).textTheme.bodyText1.color),
          ),
          subtitle: Text(_ls[i].downloaded ? '已下载' : '未下载'),
          onChanged: (e) {
            setState(() {
              if (!_ls[i].downloaded) {
                _ls[i].selected = e;
              }
            });
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'ComicDownload',
        child: Icon(Icons.file_download),
        onPressed: () {
          Fluttertoast.showToast(msg: '就快写好了');
        },
      ),
    );
  }
}
