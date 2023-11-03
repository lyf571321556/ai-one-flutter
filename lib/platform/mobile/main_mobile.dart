import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ones_ai_flutter/common/dao/user_dao.dart';
import 'package:ones_ai_flutter/models/account/user.dart';
import 'package:redux/redux.dart';
import 'package:uni_links/uni_links.dart';

import '../../common/redux/global/ones_state.dart';

void initByPlatform() {
  if (Platform.isAndroid) {
    final SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

Future<bool> isConnected() async {
  final connectivityResult = await new Connectivity().checkConnectivity();

  return connectivityResult != ConnectivityResult.none;
}

void initProxy(Dio _dio) {
  _dio.httpClientAdapter = IOHttpClientAdapter(
    createHttpClient: () {
      final HttpClient client =
          HttpClient(context: SecurityContext(withTrustedRoots: false));
      // client.findProxy = (uri) => 'PROXY 192.168.0.41:8888';

      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    },
  );
}

Future<void> saveToken(User user, Store<OnesGlobalState> store) async {
  await UserDao.saveLoginUserInfo(user, store);
}

Future<String?> getCurrentRequestUrl() async {
  final String? intentlink = await getInitialLink();
  return intentlink;
}

String getCurrentRequestUrlPath() {
  return '-------';
}

String goToDestPage(String url) {
  return '';
}
