// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en_US locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = MessageLookup();

typedef String? MessageIfAbsent(
    String? messageStr, List<Object>? args);

class MessageLookup extends MessageLookupByLibrary {
  @override
  String get localeName => 'en_US';

  static m0(minLength, maxLength) => "密码为${minLength}~${maxLength}位,且必须包含大小写字母和数字";

  static m1(name, count) => "${Intl.plural(count, zero: 'There are no clicks.', one: 'There is one click.', other: 'There are ${count} clicks.')}";

  @override
  final Map<String, dynamic> messages = _notInlinedMessages(_notInlinedMessages);

  static Map<String, dynamic> _notInlinedMessages(_) => {
      'changeLanguage': MessageLookupByLibrary.simpleMessage('切换语言'),
    'changeTheme': MessageLookupByLibrary.simpleMessage('切换主题'),
    'exitApp': MessageLookupByLibrary.simpleMessage('再点一次退出应用'),
    'languageAuto': MessageLookupByLibrary.simpleMessage('跟随系统'),
    'languageEN': MessageLookupByLibrary.simpleMessage('English'),
    'languageHK': MessageLookupByLibrary.simpleMessage('繁體中文（香港）'),
    'languageTW': MessageLookupByLibrary.simpleMessage('繁體中文（台灣）'),
    'languageZH': MessageLookupByLibrary.simpleMessage('简体中文'),
    'titleAccount': MessageLookupByLibrary.simpleMessage('账号'),
    'titleAccountError': MessageLookupByLibrary.simpleMessage('请输入正确的账号'),
    'titleAccountHint': MessageLookupByLibrary.simpleMessage('请输入账号'),
    'titleDashboard': MessageLookupByLibrary.simpleMessage('Dashboard'),
    'titleForgetPassword': MessageLookupByLibrary.simpleMessage('忘记密码?'),
    'titleHome': MessageLookupByLibrary.simpleMessage('Home'),
    'titleLanguage': MessageLookupByLibrary.simpleMessage('Language'),
    'titleLogin': MessageLookupByLibrary.simpleMessage('登录'),
    'titleLoginOut': MessageLookupByLibrary.simpleMessage('退出应用'),
    'titleNotification': MessageLookupByLibrary.simpleMessage('Notification'),
    'titlePassword': MessageLookupByLibrary.simpleMessage('密码'),
    'titlePasswordError': m0,
    'titlePasswordHint': MessageLookupByLibrary.simpleMessage('请输入密码'),
    'titleProject': MessageLookupByLibrary.simpleMessage('Project'),
    'titleSetting': MessageLookupByLibrary.simpleMessage('设置'),
    'titleTheme': MessageLookupByLibrary.simpleMessage('Theme'),
    'titleWiki': MessageLookupByLibrary.simpleMessage('Wiki'),
    'welcomeCountContent': m1
  };
}
