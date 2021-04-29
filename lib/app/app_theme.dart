import 'package:flutter/material.dart';
import 'package:flutter_dmzj/app/config_helper.dart';

class AppTheme with ChangeNotifier {
  AppTheme() {
    changeThemeMode(ConfigHelper.getThemeMode());
    changeThemeColor(ConfigHelper.getAppTheme());
  }

  static Map<String, ThemeMode> themeModes = {
    "跟随系统": ThemeMode.system,
    "开启": ThemeMode.dark,
    "关闭": ThemeMode.light,
  };

  static Map<String, Color> themeColors = {
    "胖次蓝": Colors.blue,
    "姨妈红": Colors.red,
    "咸蛋黄": Colors.yellow,
    "早苗绿": Colors.green,
    "少女粉": Colors.pink,
    "基佬紫": Colors.purple,
    "朴素灰": Colors.blueGrey
  };

  ThemeMode _themeMode;
  String _themeModeName;
  get themeMode => _themeMode;
  get themeModeName => _themeModeName;
  void changeThemeMode(int index) {
    _themeMode = AppTheme.themeModes.values.toList()[index];
    _themeModeName = AppTheme.themeModes.keys.toList()[index];
    notifyListeners();
    ConfigHelper.setAppTheme(index);
  }

  void showThemeModeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return new SimpleDialog(
          title: new Text('夜间模式'),
          children: _createThemeModeWidget(context),
        );
      },
    );
  }

  List<Widget> _createThemeModeWidget(BuildContext context) {
    List<Widget> widgets = [];
    for (var item in AppTheme.themeModes.keys) {
      widgets.add(RadioListTile(
        groupValue: item,
        value: _themeModeName,
        title: new Text(
          item,
        ),
        onChanged: (value) {
          changeThemeMode(AppTheme.themeModes.keys.toList().indexOf(item));
          Navigator.of(context).pop();
        },
      ));
    }
    return widgets;
  }

  Color _themeColor;
  String _themeColorName;
  get themeColor => _themeColor;
  get themeColorName => _themeColorName;
  void changeThemeColor(int index) {
    _themeColor = AppTheme.themeColors.values.toList()[index];
    _themeColorName = AppTheme.themeColors.keys.toList()[index];
    notifyListeners();
    ConfigHelper.setAppTheme(index);
  }

  void showThemeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return new SimpleDialog(
          title: new Text('切换主题'),
          children: _createThemeWidget(context),
        );
      },
    );
  }

  List<Widget> _createThemeWidget(BuildContext context) {
    List<Widget> widgets = [];
    for (var item in AppTheme.themeColors.keys) {
      widgets.add(RadioListTile(
        groupValue: item,
        value: _themeColorName,
        title: new Text(
          item,
          style: TextStyle(color: AppTheme.themeColors[item]),
        ),
        onChanged: (value) {
          changeThemeColor(AppTheme.themeColors.keys.toList().indexOf(item));
          Navigator.of(context).pop();
        },
      ));
    }
    return widgets;
  }
}
