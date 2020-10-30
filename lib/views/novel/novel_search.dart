import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_dmzj/app/api.dart';
import 'package:flutter_dmzj/app/utils.dart';
import 'package:flutter_dmzj/models/novel/novel_search_result_item.dart';
import 'package:flutter_dmzj/models/search_hot_word.dart';
import 'package:http/http.dart' as http;

class NovelSearchBarDelegate extends SearchDelegate<String> {
  NovelSearchBarDelegate(
      {String searchFieldLabel = "输入关键字搜索轻小说",
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

    return FutureBuilder<List<NovelSearchResultItem>>(
      future: loadData(),
      builder: (BuildContext context,
          AsyncSnapshot<List<NovelSearchResultItem>> snapshot) {
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
    if (query.length == 0) {
      return FutureBuilder<List<SearchHotWord>>(
        future: loadHotWord(),
        builder: (BuildContext context,
            AsyncSnapshot<List<SearchHotWord>> snapshot) {
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
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Wrap(
                          children: snapshot.data
                              .map((f) => createWorditem(context, f.name, f.id,
                                  type: 2))
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
    return Container();
  }

  Widget createWorditem(BuildContext context, String title, int id,
      {int type = 2}) {
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
          //Utils.openPage(context, id, type, );
          query = title;
          showResults(context);
        },
      ),
    );
  }

  Widget createItem(context, NovelSearchResultItem item) {
    return InkWell(
      onTap: () {
        Utils.openPage(context, item.id, 2, url: item.cover, title: item.title);
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
                      child: Hero(
                        tag: item.id,
                        child: Utils.createCacheImage(item.cover, 270, 360),
                      ))),
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
                    Text.rich(TextSpan(
                        text: item.authors,
                        style: TextStyle(color: Colors.grey, fontSize: 14))),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      item.types,
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<List<NovelSearchResultItem>> loadData() async {
    try {
      var response = await http.get(Api.novelSearch(this.query));
      List ls = jsonDecode(response.body);
      List<NovelSearchResultItem> detail =
          ls.map((i) => NovelSearchResultItem.fromJson(i)).toList();
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
      var response = await http.get(Api.novelSearchHotWord);
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
    return Theme.of(context);
  }
}
