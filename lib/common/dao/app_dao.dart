import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ones_ai_flutter/common/config/app_config.dart';
import 'package:ones_ai_flutter/common/redux/global/ones_state.dart';
import 'package:ones_ai_flutter/models/account/index.dart';
import 'package:redux/redux.dart';
import 'package:ones_ai_flutter/common/storage/local_storage.dart';
import 'package:ones_ai_flutter/utils/common_utils.dart';
import 'package:ones_ai_flutter/resources/index.dart';

class AppDao {
  static Future<Store<OnesGlobalState>> initApp(
      Store<OnesGlobalState> store) async {
    print('initapp');
    await LocalDataHelper.ready();
    final String userInfo = await LocalDataHelper.get(Config.USER_INFO);
    User? user; //await UserDao.getUserInfo();
    final Map<String, dynamic> userMap = json.decode(userInfo);
    user = User.fromJson(userMap);
    CommonUtils.changeUser(store, user);

    ///切换语言
    final String localInfo = await LocalDataHelper.get(Config.LOCALE);
    if (localInfo.length != 0) {
      final newlocal =
          new Locale(localInfo.split('-')[0], localInfo.split('-')[1]);
      CommonUtils.changeLocale(store, newlocal);
    }

    ThemeData newThemeData = ThemeData.light().copyWith(
        primaryColor: Colors.blueAccent,
        colorScheme: ColorScheme.fromSwatch(accentColor: Colors.blueAccent),
        indicatorColor: Colors.white,
        platform: TargetPlatform.iOS);

    final String colorKey = await LocalDataHelper.get(Config.THEME_COLOR);
    if (colorKey.length != 0) {
      newThemeData = ThemeData.light().copyWith(
          primaryColor: themeColorMap[colorKey],
          colorScheme:
              ColorScheme.fromSwatch(accentColor: themeColorMap[colorKey]),
          indicatorColor: Colors.white,
          platform: TargetPlatform.iOS);
    }
    CommonUtils.changeTheme(store, newThemeData);
    print('initapp');
    return Future.value(store);
  }
}
