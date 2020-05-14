import 'package:flutter/material.dart';
import 'package:flutter_dmzj/app/app_theme.dart';
import 'package:flutter_dmzj/app/user_info.dart';
import 'package:flutter_dmzj/app/utils.dart';
import 'package:provider/provider.dart';

class PersonalPage extends StatefulWidget {
  PersonalPage({Key key}) : super(key: key);

  @override
  _PersonalPageState createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          // Provider.of<AppUserInfo>(context, listen: false).isLogin
          //     ? InkWell(
          //         onTap: () => Navigator.pushNamed(context, "/User"),
          //         child: UserAccountsDrawerHeader(
          //           currentAccountPicture: CircleAvatar(
          //             backgroundImage: NetworkImage(
          //               Provider.of<AppUserInfo>(context).loginInfo.photo,
          //               headers: {"Referer": "http://www.dmzj.com/"},
          //             ),
          //           ),
          //           accountName: InkWell(
          //             child: Text(
          //               Provider.of<AppUserInfo>(context).loginInfo.nickname,
          //               style: TextStyle(fontWeight: FontWeight.bold),
          //             ),
          //           ),
          //           accountEmail: Text(Provider.of<AppUserInfo>(context)
          //                   .userProfile
          //                   ?.description ??
          //               ""),
          //           // decoration: BoxDecoration(
          //           //     image: DecorationImage(
          //           //   image: AssetImage("assets/img_ucenter_def_bac.jpg"),
          //           //   fit: BoxFit.cover,
          //           //   //colorFilter: ColorFilter.mode(Theme.of(context).accentColor.withOpacity(0.4), BlendMode.colorBurn)
          //           // )),
          //         ),
          //       )
          //     : InkWell(
          //         onTap: () => Navigator.pushNamed(context, "/Login"),
          //         child: UserAccountsDrawerHeader(
          //           currentAccountPicture: CircleAvatar(
          //             child: Icon(Icons.account_circle),
          //           ),
          //           accountName: InkWell(
          //             child: Text(
          //               "点击登录",
          //               style: TextStyle(fontWeight: FontWeight.bold),
          //             ),
          //           ),
          //           accountEmail: Text("登录后享受更多功能"),
          //         ),
          //       ),
          Stack(
            children: <Widget>[
              Image.asset(
                "assets/img_ucenter_def_bac.jpg",
                fit: BoxFit.cover,
                height: 240,
                width: MediaQuery.of(context).size.width,
              ),
              Positioned(
                  child: Container(
                width: MediaQuery.of(context).size.width,
                height: 240,
                padding:
                    EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Theme.of(context).accentColor.withOpacity(1),
                      Theme.of(context).accentColor.withOpacity(0.1)
                    ],
                  ),
                ),
                child: Provider.of<AppUserInfo>(context).isLogin
                    ? InkWell(
                       onTap: (){
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
                              Provider.of<AppUserInfo>(context,listen: false).logout();
                              Navigator.of(context).pop();
                            },
                          )
                        ],
                      ));
                       },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: 64,
                              height: 64,
                              child: CircleAvatar(
                                radius: 32,
                                backgroundImage:
                                    Utils.createCachedImageProvider(
                                        Provider.of<AppUserInfo>(context)
                                            .loginInfo
                                            .photo),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              Provider.of<AppUserInfo>(context)
                                  .loginInfo
                                  .nickname,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              Provider.of<AppUserInfo>(context)
                                  .userProfile?.description??"",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ],
                        ),
                      )
                    : InkWell(
                        onTap: ()=>Navigator.pushNamed(context, "/Login"),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: 64,
                              height: 64,
                              child: CircleAvatar(
                                child: Icon(Icons.account_circle),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "点击登录",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
              ))
            ],
          ),
          Material(
            color: Theme.of(context).cardColor,
            child: Column(
              children: <Widget>[
                // ListTile(
                //   title: Text("消息中心"),
                //   leading: Icon(Icons.email),
                //   trailing: Icon(Icons.chevron_right, color: Colors.grey),
                //   onTap: () => {},
                // ),
                ListTile(
                  title: Text("我的订阅"),
                  leading: Icon(Icons.favorite),
                  trailing: Icon(Icons.chevron_right, color: Colors.grey),
                  onTap: () => Utils.openSubscribePage(context),
                ),
                ListTile(
                  title: Text("浏览记录"),
                  leading: Icon(Icons.history),
                  trailing: Icon(Icons.chevron_right, color: Colors.grey),
                  onTap: () => Utils.openHistoryPage(context),
                ),
                ListTile(
                  title: Text("我的评论"),
                  leading: Icon(Icons.comment),
                  trailing: Icon(Icons.chevron_right, color: Colors.grey),
                  onTap: () => Utils.openMyCommentPage(context),
                ),
                ListTile(
                  title: Text("我的下载"),
                  trailing: Icon(Icons.chevron_right, color: Colors.grey),
                  leading: Icon(Icons.file_download),
                  onTap: () => {},
                )
              ],
            ),
          ),

          SizedBox(
            height: 12,
          ),
          Material(
            color: Theme.of(context).cardColor,
            child: Column(children: <Widget>[
              SwitchListTile(
                onChanged: (value) {
                  Provider.of<AppTheme>(context, listen: false)
                      .changeDark(value);
                },
                secondary: Icon(Icons.brightness_4),
                title: Text("夜间模式"),
                value: Provider.of<AppTheme>(context).isDark,
              ),
              ListTile(
                title: Text("设置"),
                leading: Icon(Icons.settings),
                trailing: Icon(Icons.chevron_right, color: Colors.grey),
                onTap: () {
                  Navigator.pushNamed(context, "/Setting");
                },
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
