// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh_HK locale. All the
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

typedef String? MessageIfAbsent(String? messageStr, List<Object>? args);

class MessageLookup extends MessageLookupByLibrary {
  @override
  String get localeName => 'zh_HK';

  static m0(minLength, maxLength) =>
      "密码为${minLength}~${maxLength}位,且必须包含大小写字母和数字";

  static m1(name, count) =>
      "${Intl.plural(count, zero: '你没有点击.', one: '你点击了一次.', other: '你点击了${count}次.')}";

  @override
  final Map<String, dynamic> messages =
      _notInlinedMessages(_notInlinedMessages);

  static Map<String, dynamic> _notInlinedMessages(_) => {
        'changeLanguage': MessageLookupByLibrary.simpleMessage('切換語言'),
        'changeTheme': MessageLookupByLibrary.simpleMessage('切换主題'),
        'exitApp': MessageLookupByLibrary.simpleMessage('再点一次退出应用'),
        'languageAuto': MessageLookupByLibrary.simpleMessage('跟隨系統'),
        'languageEN': MessageLookupByLibrary.simpleMessage('English'),
        'languageHK': MessageLookupByLibrary.simpleMessage('繁體中文（香港）'),
        'languageTW': MessageLookupByLibrary.simpleMessage('繁體中文（台灣）'),
        'languageZH': MessageLookupByLibrary.simpleMessage('简体中文'),
        'titleAccount': MessageLookupByLibrary.simpleMessage('账号'),
        'titleAccountError': MessageLookupByLibrary.simpleMessage('请输入正确的账号'),
        'titleAccountHint': MessageLookupByLibrary.simpleMessage('请输入账号'),
        'titleDashboard': MessageLookupByLibrary.simpleMessage('HK-仪表盘'),
        'titleForgetPassword': MessageLookupByLibrary.simpleMessage('忘记密码?'),
        'titleHome': MessageLookupByLibrary.simpleMessage('主頁'),
        'titleLanguage': MessageLookupByLibrary.simpleMessage('語言'),
        'titleLogin': MessageLookupByLibrary.simpleMessage('登錄'),
        'titleLoginOut': MessageLookupByLibrary.simpleMessage('退出应用'),
        'titlePassword': MessageLookupByLibrary.simpleMessage('密码'),
        'titlePasswordError': m0,
        'titlePasswordHint': MessageLookupByLibrary.simpleMessage('请输入密码'),
        'titleProject': MessageLookupByLibrary.simpleMessage('HK-项目'),
        'titleSetting': MessageLookupByLibrary.simpleMessage('设置'),
        'titleTheme': MessageLookupByLibrary.simpleMessage('主題'),
        'titleWiki': MessageLookupByLibrary.simpleMessage('HK-文档'),
        'welcomeCountContent': m1
      };
}
