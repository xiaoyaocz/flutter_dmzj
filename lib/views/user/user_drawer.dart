import 'package:flutter/material.dart';
import 'package:flutter_dmzj/app/app_theme.dart';
import 'package:flutter_dmzj/app/user_info.dart';
import 'package:flutter_dmzj/app/utils.dart';
import 'package:provider/provider.dart';

class UserDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Provider.of<AppUserInfo>(context, listen: false).isLogin
              ? InkWell(
                  onTap: () => Navigator.pushNamed(context, "/User"),
                  child: UserAccountsDrawerHeader(
                    currentAccountPicture: CircleAvatar(
                      backgroundImage: NetworkImage(
                        Provider.of<AppUserInfo>(context, listen: false)
                            .loginInfo
                            .photo,
                        headers: {"Referer": "http://www.dmzj.com/"},
                      ),
                    ),
                    accountName: InkWell(
                      child: Text(
                        Provider.of<AppUserInfo>(context, listen: false)
                            .loginInfo
                            .nickname,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    accountEmail: Text(
                        Provider.of<AppUserInfo>(context, listen: false)
                                .userProfile
                                ?.description ??
                            ""),
                    // decoration: BoxDecoration(
                    //     image: DecorationImage(
                    //   image: AssetImage("assets/img_ucenter_def_bac.jpg"),
                    //   fit: BoxFit.cover,
                    //   //colorFilter: ColorFilter.mode(Theme.of(context).accentColor.withOpacity(0.4), BlendMode.colorBurn)
                    // )),
                    
                  ),
                )
              : InkWell(
                  onTap: () => Navigator.pushNamed(context, "/Login"),
                  child: UserAccountsDrawerHeader(
                    currentAccountPicture: CircleAvatar(
                      child: Icon(Icons.account_circle),
                    ),
                    accountName: InkWell(
                      child: Text(
                        "点击登录",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    accountEmail: Text("登录后享受更多功能"),
                  ),
                ),
          ListTile(
            title: Text("消息中心"),
            leading: Icon(Icons.email),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            title: Text("我的订阅"),
            leading: Icon(Icons.favorite),
            onTap: () =>Utils.openSubscribePage(context),
          ),
          ListTile(
            title: Text("浏览记录"),
            leading: Icon(Icons.history),
            onTap:() =>Utils.openHistoryPage(context),
          ),
          ListTile(
            title: Text("我的评论"),
            leading: Icon(Icons.comment),
            onTap:() =>Utils.openMyCommentPage(context),
          ),
          ListTile(
            title: Text("我的下载"),
            leading: Icon(Icons.file_download),
            onTap: () => Navigator.pop(context),
          ),
          Divider(),
          SwitchListTile(
            onChanged: (value) {
              Provider.of<AppTheme>(context, listen: false).changeDark(value);
            },
            secondary: Icon(Icons.brightness_4),
            title: Text("夜间模式"),
            value: Provider.of<AppTheme>(context, listen: false).isDark,
          ),
          ListTile(
            title: Text("设置"),
            leading: Icon(Icons.settings),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, "/Setting");
            },
          ),
        ],
      ),
    );
  }
}
