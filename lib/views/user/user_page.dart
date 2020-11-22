import 'package:flutter/material.dart';
import 'package:flutter_dmzj/provider/user_info_provider.dart';
import 'package:flutter_dmzj/helper/utils.dart';

import 'package:provider/provider.dart';

class UserPage extends StatefulWidget {
  UserPage({Key key}) : super(key: key);

  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Container(
              height: 36,
              width: 36,
              child: CircleAvatar(
                backgroundImage: Utils.createCachedImageProvider(
                    Provider.of<AppUserInfoProvider>(context).userProfile?.cover),
              ),
            ),
            SizedBox(width: 12),
            Text(Provider.of<AppUserInfoProvider>(context).loginInfo?.nickname),
          ],
        ),
        actions: <Widget>[
          FlatButton(
            child: Text("退出登录"),
            textColor: Colors.white,
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                        title: Text("退出登录"),
                        content: Text("确定要退出登录吗?"),
                        actions: <Widget>[
                          new FlatButton(
                            child: new Text("取消"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          new FlatButton(
                            child: new Text("确定"),
                            onPressed: () {
                              Provider.of<AppUserInfoProvider>(context).logout();
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            },
                          )
                        ],
                      ));
            },
          )
        ],
      ),
      body: Text(Provider.of<AppUserInfoProvider>(context).loginInfo?.nickname ?? ""),
    );
  }
}
