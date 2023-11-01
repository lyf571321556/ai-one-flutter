import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'package:ones_ai_flutter/ui/pages/home_page.dart';
import 'package:ones_ai_flutter/ui/pages/setting/language_page.dart';
import 'package:ones_ai_flutter/ui/pages/login_page.dart';
import 'package:ones_ai_flutter/ui/pages/setting/theme_page.dart';
import 'package:ones_ai_flutter/ui/pages/wiki/list/mobile_web_page.dart';

class PageRouteManager {
  static final String rootPagePath = '/';
  static final String loginPagePath = '/login';
  static final String homePagePath = '/home1';
  static final String languagePagePath = '/language';
  static final String themePagePath = '/theme';
  static final String webViewPath = '/webview/:data';
  static FluroRouter pageRouter = FluroRouter.appRouter;

  static Widget? notSupportPage(
      BuildContext? context, Map<String, List<String>> params) {
    return Container();
  }

  static void initRoutes() {
    pageRouter = new FluroRouter();
    pageRouter.notFoundHandler = new Handler(handlerFunc: notSupportPage);

    pageRouter.define(loginPagePath, handler: _loginPageHandler);
    pageRouter.define(homePagePath, handler: _homePageHandler);
    pageRouter.define(languagePagePath, handler: _languagePageHandler);
    pageRouter.define(themePagePath, handler: _themePageHandler);
    pageRouter.define(webViewPath, handler: _webViewPageHandler);
  }

  static final Handler _loginPageHandler = new Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
    print("接收参数${params['param'].first}");
    return LoginPage();
  });

  static final Handler _homePageHandler = new Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
    print("接收参数${params['param'].first}");
    return HomePage();
  });

  static final Handler _languagePageHandler = new Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
    print("接收参数${params['param'].first}");
    return LanguageSelectPage();
  });

  static final Handler _themePageHandler = new Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
    print("接收参数${params['param'].first}");
    return ThemeSelectPage();
  });

  static final Handler _webViewPageHandler = new Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
    print("接收参数${params['param'].first}");
    print("接收参数${params['data'].first}");
    return WebViewPage();
  });

  static openNewPage(BuildContext context, String pagePath,
      {Map<String, dynamic>? params,
      bool replace = false,
      TransitionType transition = TransitionType.cupertino}) {
    String query = '';
    if (params != null) {
      params.forEach((key, value) {
        query = key + '=' + Uri.encodeComponent(value);
      });
    } else {
      query = "param=${Uri.encodeComponent('hello')}";
    }
    pageRouter.navigateTo(context, '${pagePath}?${query}',
        replace: replace,
        transition: transition,
        transitionDuration: Duration(milliseconds: 400));
  }

  static closePage(BuildContext context) {
    pageRouter.pop(context);
  }
}
