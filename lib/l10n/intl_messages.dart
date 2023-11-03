import 'package:intl/intl.dart';

mixin LocalizationMessagesMixin {
  String get titleHome {
    return Intl.message('APP名称', name: 'titleHome', desc: '应用的标题名称');
  }

  String welcomeCountContent(String name, int count) {
    return Intl.plural(count,
        zero: '你没有点击.',
        one: '你点击了一次.',
        other: '你点击了$count次.',
        name: 'welcomeCountContent',
        args: [name, count],
        desc: '欢迎页面点击次数',
        examples: const {'name': 'tom', 'count': 1});
  }

  String get exitApp {
    return Intl.message('再点一次退出应用', name: 'exitApp', desc: '点击退出APP提示');
  }

  String get titleLoginOut {
    return Intl.message('退出应用', name: 'titleLoginOut', desc: '退出应用提示');
  }

  String get titleSetting {
    return Intl.message('设置', name: 'titleSetting', desc: '应用-设置');
  }

  String get titleLanguage {
    return Intl.message('语言', name: 'titleLanguage', desc: '应用-语言');
  }

  String get changeLanguage {
    return Intl.message('切换语言', name: 'changeLanguage', desc: '应用-切换语言');
  }

  String get titleTheme {
    return Intl.message('主题', name: 'titleTheme', desc: '应用-主题');
  }

  String get changeTheme {
    return Intl.message('切换主题', name: 'changeTheme', desc: '应用-切换主题');
  }

  String get languageAuto {
    return Intl.message('跟随系统', name: 'languageAuto', desc: '应用-切换主题-跟随系统');
  }

  String get languageZH {
    return Intl.message('简体中文', name: 'languageZH', desc: '应用-切换语言-简体中文');
  }

  String get languageTW {
    return Intl.message('繁體中文（台灣）',
        name: 'languageTW', desc: '应用-切换语言-繁體中文（台灣）');
  }

  String get languageHK {
    return Intl.message('繁體中文（香港）',
        name: 'languageHK',
        desc: '应'
            '用-切换语言-繁體中文（香港）');
  }

  String get languageEN {
    return Intl.message('English', name: 'languageEN', desc: '应用-切换语言-English');
  }

  String get titleLogin {
    return Intl.message('登录', name: 'titleLogin', desc: '登录页面');
  }

  String get titleAccount {
    return Intl.message('账号', name: 'titleAccount', desc: '账号');
  }

  String get titleAccountHint {
    return Intl.message('请输入账号', name: 'titleAccountHint', desc: '登录账号输入提示');
  }

  String get titleAccountError {
    return Intl.message('请输入正确的账号',
        name: 'titleAccountError', desc: '登录账号验证提示');
  }

  String get titlePassword {
    return Intl.message('密码', name: 'titlePassword', desc: '密码');
  }

  String get titlePasswordHint {
    return Intl.message('请输入密码', name: 'titlePasswordHint', desc: '登录密码输入提示');
  }

  String titlePasswordError(int minLength, int maxLength) {
    return Intl.message('密码为$minLength~$maxLength位,且必须包含大小写字母和数字',
        args: [minLength, maxLength],
        name: 'titlePasswordError',
        desc: '登录密码验证提示');
  }

  String get titleForgetPassword {
    return Intl.message('忘记密码?',
        name: 'titleForgetPassword', desc: '忘记密码入口按钮文字');
  }

  String get titleProject {
    return Intl.message('项目', name: 'titleProject', desc: '底部导航栏-项目');
  }

  String get titleWiki {
    return Intl.message('文档', name: 'titleWiki', desc: '底部导航栏-文档');
  }

  String get titleDashboard {
    return Intl.message('仪表盘', name: 'titleDashboard', desc: '底部导航栏-仪表盘');
  }

  String get titleNotification {
    return Intl.message('通知', name: 'titleNotification', desc: '底部导航栏-通知');
  }
}
