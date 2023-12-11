// 管理APP的全局变量 以及启动
// 注意：colorswatch的值需要重新定义
import 'dart:convert';
import 'package:untitled/models/user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/models/index.dart';

// 提供2套可选主题色
const _themes = <MaterialColor>[
  Colors.blueGrey,
  Colors.indigo,
];

class Global{

  static late SharedPreferences _preferences;
  // 全局共享主题
  static Profile profile = Profile();
  // static NetCache netCache = NetCache();// 网络缓存对象

  // 可选的主题列表
  static List<MaterialColor> get themes => _themes;

  // 是否为release版
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");

  // 初始化全局信息，在APP启动时执行，返回异步操作future（uncompleted/completed）
  static Future init() async{
    WidgetsFlutterBinding.ensureInitialized();
    // awit 关键字暂停当前异步函数的执行
    _preferences = await SharedPreferences.getInstance();
    var _profile = _preferences.getString("profile");
    if(_profile != null){
      try{
        profile = Profile.fromJson(jsonDecode(_profile));
      }catch(e){
        print(e);
      }
    }else{
      // 默认主题索引
      profile = Profile()..theme = 0;
    }
    // 如果没有缓存策略，则默认缓存策略
    profile.cache = profile.cache ?? CacheConfig()
      ..enable = true
      ..maxAge = 3600
      ..maxCount = 100;

    // 初始化网络及相关配置
  }

  // 持久化Profile信息
  static saveProfile() =>
      _preferences.setString("proflie", jsonEncode(profile.toJson()));
}

class ProfileChangeNotifier extends ChangeNotifier{
  Profile get _profile => Global.profile;

  @override
  void notifyListeners(){
    Global.saveProfile();//保存更新
    super.notifyListeners();//通知依赖的widget更新
  }
}

// 用户信息 用户登录状态发生变化时更新、通知其依赖项
class UserModel extends ProfileChangeNotifier{
  User? get getuser => _profile.user;
  // APP是否登录(如果有用户信息，则证明登录过)
  bool get isLogin => getuser != null;

  set setuser(User user){
    if (user?.login != _profile.user?.login) {
      _profile.lastLogin = _profile.user?.login;
      _profile.user = user;
      notifyListeners();
    }
  }
}

// APP主题更新
class ThemeModel extends ProfileChangeNotifier{
  // 获取当前主题，如果不设置，则默认
  ColorSwatch get theme => Global.themes
      .firstWhere((element) => element.value == _profile.theme, orElse: ()=> Colors.blueGrey);

  // 主题改变后， 通知依赖项，新主题生效
  set theme(ColorSwatch colorSwatch){
    // if(colorSwatch != theme && colorSwatch[500]!= null){
      // _profile.theme = colorSwatch[500].value;}
      _profile.theme = 0;
      notifyListeners();

  }
}

// 定义一个语言类
/*
class LocaleModel extends ProfileChangeNotifier {
  // 获取当前用户的APP语言配置Locale类，如果为null，则语言跟随系统语言
  Locale getLocale() {
    // 设置： profile文件中为string 不能返回null
    // if (_profile.locale == null) return null;
    var t = _profile.locale.split("_");
    return Locale(t[0], t[1]);
  }

  // 获取当前Locale的字符串表示
  String get locale => _profile.locale;

  // 用户改变APP语言后，通知依赖项更新，新语言会立即生效
  set locale(String locale) {
    if (locale != _profile.locale) {
      _profile.locale = locale;
      notifyListeners();
    }
  }
}*/
