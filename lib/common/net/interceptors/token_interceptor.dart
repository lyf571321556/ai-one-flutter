import 'package:dio/dio.dart';

class TokenInterceptor extends InterceptorsWrapper {
  String? _userId, _token;

  @override
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers['Ones-User-Id'] = _userId;
    options.headers['Ones-Auth-Token'] = _token;
    options.headers['Access-Control-Allow-Origin'] = '*';
    options.headers['content-type'] = 'application/json';
    options.contentType = 'application/json';
    super.onRequest(options, handler);
  }

//
//  @override
//  onResponse(Response response) async {
//    try {
//      var responseJson = response.data;
//      if (response.statusCode == 200 && responseJson["token"] != null) {
//        _token = 'token ' + responseJson["token"];
//        await LocalStorage.save(Config.TOKEN_KEY, _token);
//      }
//    } catch (e) {
//      print(e);
//    }
//    return response;
//  }

  ///清除授权
  void clearAuthorization() {
    this._userId = '';
    this._token = '';
  }

  TokenInterceptor withUserId(String userId) {
    this._userId = userId;
    return this;
  }

  TokenInterceptor withToken(String token) {
    this._token = token;
    return this;
  }
}
