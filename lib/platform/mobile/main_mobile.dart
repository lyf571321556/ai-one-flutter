import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ones_ai_flutter/common/config/app_config.dart';
import 'package:ones_ai_flutter/common/dao/user_dao.dart';
import 'package:ones_ai_flutter/main.dart';
import 'package:ones_ai_flutter/models/account/user.dart';
import 'package:redux/redux.dart';
import 'package:uni_links/uni_links.dart';

import '../../common/redux/global/ones_state.dart';

void initByPlatform() {
  Config.runInWeb = identical(0, 0.0);
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

Future<bool> isConnected() async {
  var connectivityResult = await (new Connectivity().checkConnectivity());

  return connectivityResult != ConnectivityResult.none;
}

void initProxy(Dio _dio) {
  (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
      (client) {
//    client.findProxy = (uri) {
//      return Config.RELEASE ? 'DIRECT' : "PROXY 192.168.1.213:8888";
//    };
    if (!Config.RELEASE) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        return true;
      };
    }
  };
}

Future<void> saveToken(User user, Store<OnesGlobalState> store) async {
  await UserDao.saveLoginUserInfo(user, store);
}

Future<String> getCurrentRequestUrl() async {
  String? intentlink = await getInitialLink();
  return intentlink!;
}

String getCurrentRequestUrlPath() {
  return "-------";
}

String goToDestPage(String url) {
  return "";
}
