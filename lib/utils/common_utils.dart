import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ones_ai_flutter/common/redux/global/user_redux.dart';
import 'package:ones_ai_flutter/models/account/user.dart';
import 'package:redux/redux.dart';
import 'package:ones_ai_flutter/common/redux/global/ones_state.dart';
import 'package:ones_ai_flutter/common/redux/global/locale_redux.dart';
import 'package:ones_ai_flutter/common/redux/global/theme_redux.dart';

class CommonUtils {
  static Locale curLocale = Locale("", "");

  static changeLocale(Store<OnesGlobalState> store, Locale? newlocale) {
    if (newlocale != null) {
      store.dispatch(ChangeLocaleAction(newlocale));
    }
  }

  static changeTheme(Store<OnesGlobalState> store, ThemeData? newThemeData) {
    ThemeData? themeData = store.state.themeData;
    if (newThemeData != null) {
      themeData = newThemeData;
    }
    store.dispatch(ChangeThemeDataAction(themeData));
  }

  static changeUser(Store<OnesGlobalState> store, User? newUser) {
    store.dispatch(UserChangeActioin(newUser));
  }
}
