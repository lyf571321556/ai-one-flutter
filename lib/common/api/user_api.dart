import 'package:dio/dio.dart';
import 'package:ones_ai_flutter/common/net/dio/http_manager.dart';
import 'package:ones_ai_flutter/common/net/dio/http_result.dart';
import 'package:ones_ai_flutter/models/account/index.dart';

class UserApi {
  static final String LOGIN_URL = 'auth/v2/login';

  static Future<HttpResult> login(
      String userName, String password, CancelToken? token) async {
    final Map<String, dynamic> bodyParams = {
      'password': password,
      'email': userName,
    };
    final dynamic data = await HttpManager.getInstance()
        .post(LOGIN_URL, bodyParams: bodyParams)
        .then((result) {
      if (result.isSuccess) {
        result.data = User.fromJson(result.data['user']);
      }
      return result;
    }).catchError((e) {
      return HttpResult()..data = e;
    });
    return Future.value(data);
  }
}
