import 'package:flutter/material.dart';
import 'package:flutter_dmzj/app/app_theme.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("设置"),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8),
            child: Text('应用主题'),
          ),
          Container(
            color: Theme.of(context).cardColor,
            child: SwitchListTile(
              onChanged: (value) {
                Provider.of<AppTheme>(context,listen: false).changeDark(value);
              },
              secondary: Icon(Icons.brightness_4),
              title: Text("夜间模式"),
              value: Provider.of<AppTheme>(context,listen: false).isDark,
            ),
          ),
          //主题设置
          Container(
            color: Theme.of(context).cardColor,
            child: ListTile(
              title: Text("主题切换"),
              leading: Icon(Icons.color_lens),
              trailing: Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  Provider.of<AppTheme>(context,listen: false).themeColorName,
                  style: TextStyle(
                      color: Provider.of<AppTheme>(context,listen: false).themeColor,
                      fontSize: 14.0),
                ),
              ),
              onTap: () => Provider.of<AppTheme>(context,listen: false).showThemeDialog(
                  context), //Provider.of<AppThemeData>(context).changeThemeColor(3),
            ),
          ),
          //移动网络设置
          Padding(
            padding: EdgeInsets.all(8),
            child: Text('移动网络'),
          ),
          Container(
            color: Theme.of(context).cardColor,
            child: SwitchListTile(
              onChanged: (value) {},
              title: Text("移动网络观看漫画"),
              value: false,
            ),
          ),
          Container(
            color: Theme.of(context).cardColor,
            child: SwitchListTile(
              onChanged: (value) {},
              title: Text("移动网络下载漫画"),
              value: false,
            ),
          ),
          Container(
            color: Theme.of(context).cardColor,
            child: SwitchListTile(
              onChanged: (value) {},
              title: Text("移动网络观看小说"),
              value: false,
            ),
          ),
          Container(
            color: Theme.of(context).cardColor,
            child: SwitchListTile(
              onChanged: (value) {},
              title: Text("移动网络下载小说"),
              value: false,
            ),
          ),
          
        ],
      ),
    );
  }
}
