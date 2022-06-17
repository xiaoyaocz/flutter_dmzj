import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dmzj/app/api.dart';
import 'package:flutter_dmzj/app/utils.dart';
import 'package:flutter_dmzj/models/comic/comic_ns_search_item.dart';
import 'package:flutter_dmzj/models/search_hot_word.dart';
import 'package:http/http.dart' as http;

class ComicSearchBarDelegate extends SearchDelegate<String> {
  ComicSearchBarDelegate(
      {String searchFieldLabel = "输入关键字搜索漫画",
      TextInputType keyboardType,
      TextInputAction textInputAction = TextInputAction.search})
      : super(
            searchFieldLabel: searchFieldLabel,
            keyboardType: keyboardType,
            textInputAction: textInputAction);
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.search),
        onPressed: () {
          showResults(context);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (this.query.length == 0) {
      return Container();
    }

    //patch start
    if(this.query.contains(RegExp(r'^id\d+$'))){//id12345
      Utils.openPage(context, int.parse(this.query.replaceAll(RegExp(r'\d'), '')), 1);
      return Container();//?
    }
    //patch end
    return FutureBuilder<List<ComicNSSearchItem>>(
      future: loadData(),
      builder: (BuildContext context,
          AsyncSnapshot<List<ComicNSSearchItem>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Container();
          case ConnectionState.active:
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(),
            );
          case ConnectionState.done:
            if (snapshot.hasError)
              return Center(
                child: Text("搜索失败"),
              );
            return ListView(
              children:
                  snapshot.data.map((f) => createItem(context, f)).toList(),
            );
        }
        return null; // unreachable
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<List<SearchHotWord>>(
      future: loadHotWord(),
      builder:
          (BuildContext context, AsyncSnapshot<List<SearchHotWord>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Container();
          case ConnectionState.active:
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(),
            );
          case ConnectionState.done:
            if (snapshot.hasError)
              return Center(
                child: Text("搜索失败"),
              );
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      "热门搜索",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Wrap(
                        children: snapshot.data
                            .map((f) =>
                                createWorditem(context, f.name, f.id, type: 1))
                            .toList(),
                      ))
                ],
              ),
            );
        }
        return null; // unreachable
      },
    );
  }

  Widget createWorditem(BuildContext context, String title, int id,
      {int type = 1}) {
    return Padding(
      padding: EdgeInsets.all(4),
      child: InkWell(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Theme.of(context).accentColor)),
          child: Text(
            title,
            style: TextStyle(color: Theme.of(context).accentColor),
          ),
        ),
        onTap: () {
          Utils.openPage(context, id, type);
        },
      ),
    );
  }

  Widget createItem(context, ComicNSSearchItem item) {
    return InkWell(
      onTap: () {
        Utils.openPage(context, item.id, 1);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
        child: Container(
          padding: EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: Colors.grey.withOpacity(0.1)))),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Container(
                    width: 80,
                    child: Utils.createCacheImage(item.cover, 270, 360),
                  )),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      item.title,
                      maxLines: 1,
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text.rich(
                      TextSpan(children: [
                        WidgetSpan(
                            child: Icon(
                          Icons.account_circle,
                          color: Colors.grey,
                          size: 18,
                        )),
                        TextSpan(
                          text: " ",
                        ),
                        TextSpan(
                            text: item.author,
                            style: TextStyle(color: Colors.grey, fontSize: 14))
                      ]),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(item.status,
                        style: TextStyle(color: Colors.grey, fontSize: 14)),
                    // SizedBox(
                    //   height: 2,
                    // ),
                    // Text(
                    //   item.desc,
                    //   style: TextStyle(color: Colors.grey, fontSize: 14),
                    //   overflow: TextOverflow.ellipsis,
                    //   maxLines: 2,
                    // ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<List<ComicNSSearchItem>> loadData() async {
    try {
      var response = await http.get(Uri.parse(Api.comicSacgSearch(this.query)));
      var jsonMap = jsonDecode(
          response.body.substring(20, response.body.lastIndexOf(';')));
      List ls = jsonMap;
      List<ComicNSSearchItem> detail =
          ls.map((i) => ComicNSSearchItem.fromJson2(i)).toList();
      if (detail != null) {
        return detail;
      }
    } catch (e) {
      print(e);
    }
    return [];
  }

  Future<List<SearchHotWord>> loadHotWord() async {
    try {
      var response = await http.get(Uri.parse(Api.comicSearchHotWord));
      List ls = jsonDecode(response.body);
      List<SearchHotWord> detail =
          ls.map((i) => SearchHotWord.fromJson(i)).toList();
      if (detail != null) {
        return detail;
      }
    } catch (e) {
      print(e);
    }
    return [];
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return super.appBarTheme(context);
  }
}
