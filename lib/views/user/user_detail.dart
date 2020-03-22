import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dmzj/app/api.dart';
import 'package:flutter_dmzj/app/utils.dart';
import 'package:flutter_dmzj/models/user/user_profile.dart';
import 'package:flutter_dmzj/models/user/user_subscribe_item.dart';
import 'package:flutter_dmzj/widgets/user_comment_widget.dart';
import 'package:flutter_dmzj/widgets/user_subscribe_widget.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class UserDetailPage extends StatefulWidget {
  int user_id;
  int initPage=0;
  UserDetailPage(this.user_id, {Key key,this.initPage=0}) : super(key: key);

  @override
  _UserDetailPageState createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {

  @override
  void initState() {
    super.initState();
    loadProfile();
  }
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: widget.initPage,
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title:_profile!=null? Row(
            children: <Widget>[
               Container(
                height: 36,
                width: 36,
                child: CircleAvatar(
                  backgroundImage:Utils.createCachedImageProvider( _profile.cover),
                ),
              ),
              SizedBox(width: 12),
              Text(_profile.nickname),
            ],
          ):Container(),
          bottom: TabBar(tabs: [
            Tab(text: "漫画订阅"),
            Tab(text: "漫画评论"),
            Tab(text: "小说订阅"),
            Tab(text: "小说评论"),
          ]),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.mail_outline), onPressed: () {
              Fluttertoast.showToast(msg: '啊，还没写完呢');
            })
          ],
        ),
        body: TabBarView(children: [
          SubscribeTabView(widget.user_id,type: 0,),
          UserCommentWidget(0,widget.user_id),
          SubscribeTabView(widget.user_id,type: 1,),
          UserCommentWidget(1,widget.user_id),
        ]),
      ),
    );
  }
  UserProfileModel _profile;
  Future loadProfile() async{
     try {
      var result = await http.get(Api.userProfile(widget.user_id.toString(), ""));
      var body = result.body;
      var data = UserProfileModel.fromJson(jsonDecode(body));
      if (data != null) {
       setState(() {
         _profile=data;
       });
      }
    } catch (e) {
      print(e);
    }
  }
  
}

class SubscribeTabView extends StatefulWidget {
  int type = 0;
  int uid=0;
  SubscribeTabView( this.uid,{Key key,this.type=0}) : super(key: key);

  @override
  _SubscribeTabViewState createState() => _SubscribeTabViewState();
}

class _SubscribeTabViewState extends State<SubscribeTabView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  int _sub_type = 1;
  
  int _select_letters = 0;
  
    @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }
  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      header: MaterialHeader(),
      footer: MaterialFooter(),
      child: SingleChildScrollView(
        child:  _loading&&_page==0?Center(
              child: CircularProgressIndicator(),
            ): UserSubscribeWidget(_list,type: widget.type,),
      ),
      onRefresh: () async {
        _page = 0;

        await loadData();
      },
      onLoad: loadData,
    );
  }

 
  List<SubscribeItem> _list = [];
  int _page = 0;
  bool _loading = false;
  Future loadData() async {
    try {
      if (_loading) {
        return;
      }
      setState(() {
        _loading = true;
      });
      var response = await http.get(Api.userSubscribe(
          widget.type,
          _sub_type,
          widget.uid.toString(),
          "",
          letter: "all",
          page: _page));

      List jsonMap = jsonDecode(response.body);

      List<SubscribeItem> detail =
          jsonMap.map((f) => SubscribeItem.fromJson(f)).toList();
      if (detail != null) {
        setState(() {
          if (_page == 0) {
            _list = detail;
          } else {
            _list.addAll(detail);
          }
        });
        if (detail.length != 0) {
          _page++;
        } else {
          Fluttertoast.showToast(msg: "加载完毕");
        }
      }
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }


}
