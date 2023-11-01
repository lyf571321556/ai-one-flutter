import 'dart:async';

import 'package:dio/dio.dart';
import 'package:ones_ai_flutter/common/config/app_config.dart';
import 'package:ones_ai_flutter/common/net/dio/http_code.dart';
import 'package:ones_ai_flutter/common/net/dio/http_result.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../interceptors/token_interceptor.dart';
import 'package:ones_ai_flutter/platform/web/main_web.dart'
    if (dart.library.io) 'package:ones_ai_flutter/platform/mobile/main_mobile.dart';

enum HttpMethod { POST, GET }

class HttpManager {
  static final int CONNECT_TIMEOUT = 5000;
  static final int WRITE_TIMEOUT = 5000;
  static final int READ_TIMEOUT = 5000;
  static Dio? _httpClient;
  static final String web_dev_baseUrl = 'http://127.0.0.1:3000/api/';
  static final String mobile_dev_baseUrl = 'https://devapi.myones.net/';
  static final String web_release_baseUrl = 'http://127.0.0.1:3000/api/';
  static final String mobile_release_baseUrl = 'https://devapi.myones.net/';
  final TokenInterceptor _tokenInterceptors = new TokenInterceptor();

  factory HttpManager() => _sharedInstance();

  static HttpManager? _instance;

  String _getBaseUrl() {
    if (Config.RELEASE) {
      return Config.runInWeb ? web_release_baseUrl : mobile_release_baseUrl;
    } else {
      return Config.runInWeb ? web_dev_baseUrl : mobile_dev_baseUrl;
    }
  }

  HttpManager._internal() {
    _initClient();
  }

  static HttpManager _sharedInstance() {
    if (_instance == null) {
      _instance = HttpManager._internal();
    }
    return _instance!;
  }

  static HttpManager getInstance() => new HttpManager();

  void _initClient() {
    final BaseOptions baseOption = new BaseOptions(
        method: 'POST',
        baseUrl: _getBaseUrl(),
        connectTimeout: Duration(minutes: CONNECT_TIMEOUT),
        receiveTimeout: Duration(minutes: READ_TIMEOUT),
        sendTimeout: Duration(minutes: WRITE_TIMEOUT));
    _httpClient = new Dio(baseOption);
    _httpClient!.interceptors.add(_tokenInterceptors);
    if (!Config.RELEASE) {
      _httpClient!.interceptors
          .add(PrettyDioLogger(responseHeader: true, requestBody: true));
    }
    initProxy(_httpClient!);
  }

  clearAuthorization() {
    print('dio clearAuthorization start');
    _tokenInterceptors.clearAuthorization();
    print('dio clearAuthorization end');
  }

  initAuthorization(String userId, String token) {
    print('dio initAuthorization start');
    _tokenInterceptors.withUserId(userId).withToken(token);
    print('dio initAuthorization end');
  }

  Future<HttpResult<dynamic>> get(String url,
      {required Map<String, dynamic> pathParams,
      required CancelToken token}) async {
    return _request(url,
        httpMethod: HttpMethod.GET, pathParams: pathParams, token: token);
  }

  bool handleError(Response response) {
    if (response.statusCode == HttpCode.SUCCEED) {
      return true;
    } else {
      return false;
    }
  }

  Future<HttpResult> post(String url,
      //FutureOr<T> task(Response value)
      {Map<String, dynamic> pathParams = const {},
      Map<String, dynamic> bodyParams = const {},
      FormData? formData,
      CancelToken? token}) async {
    return await _request(url,
        httpMethod: HttpMethod.POST,
        pathParams: pathParams,
        bodyParams: bodyParams,
        formData: formData ?? FormData.fromMap({}),
        token: token ?? CancelToken());
//            .then((response) {
//      if (response == null) {
//        return Future.value(null);
//      }
//      R data = null;
//      if (resultCallBack != null) {
//        data = resultCallBack.onParseData(response);
//      }
//      return Future.value(data);
//    }).then((r) {
//      if (resultCallBack != null && r != null) {
//        resultCallBack.OnSuccess(r);
//      }
//      return Future.value(r);
//    })
//        .catchError((error) {
//      print("catchErrorcatchErrorcatchError");
//      print(error);
////      response.statusCode = HttpCode.PARSE_DATA_ERROR_CODE;
////      response.statusMessage = error.toString();
////      resultCallBack.onError(response);
//    });
//     ;
//        .then(task)
//        .catchError((error) {
//          print("处理数据错误：" + error.toString());
//        });
  }

  Future<HttpResult> upload(String url,
      {Map<String, dynamic> pathParams = const {},
      required FormData formData,
      ProgressCallback? onSendprogressCallBack,
      ProgressCallback? onReceiveProgressCallBack,
      required CancelToken token}) async {
    return _request(url,
        httpMethod: HttpMethod.POST,
        pathParams: pathParams,
        formData: formData,
        onSendprogressCallBack: onSendprogressCallBack,
        onReceiveProgressCallBack: onReceiveProgressCallBack,
        token: token);
  }

  Future<HttpResult> _request(
    String url, {
    required HttpMethod httpMethod,
    Map<String, dynamic>? pathParams,
    Map<String, dynamic>? bodyParams,
    FormData? formData,
    ProgressCallback? onSendprogressCallBack,
    ProgressCallback? onReceiveProgressCallBack,
    required CancelToken token,
  }) async {
    assert(url.length > 0);
    HttpResult httpResult = new HttpResult();
    if (pathParams != null && pathParams.isNotEmpty) {
      pathParams.forEach((key, value) {
        if (url.indexOf(key) != -1) {
          url = url.replaceAll('{$key}', Uri.encodeComponent(value));
        }
      });
    }
    HttpResult catchError(DioException e) {
      final HttpResult httpResult = new HttpResult();
      if (e.response != null) {
        httpResult.statusCode = e.response?.statusCode;
        httpResult.statusMessage = e.response?.statusMessage;
        httpResult.data = e.response?.data;
      }
      switch (e.type) {
        case DioExceptionType.receiveTimeout:
          httpResult.statusCode = HttpCode.INVALID_NETWORK_CODE;
          break;
        case DioExceptionType.connectionTimeout:
          httpResult.statusCode = HttpCode.INVALID_NETWORK_CODE;
          break;
        case DioExceptionType.sendTimeout:
          httpResult.statusCode = HttpCode.INVALID_NETWORK_CODE;
          break;
        case DioExceptionType.badResponse:
          break;
        case DioExceptionType.cancel:
          httpResult.statusCode = HttpCode.CANCEL_ERROR_CODE;
          break;
        case DioExceptionType.unknown:
          if (e.error != null) {
//            if (e.error is SocketException) {
//              httpResult.statusCode = HttpCode.INVALID_NETWORK_CODE;
//              httpResult.statusMessage =
//                  (e.error as SocketException).toString();
//            } else {
            httpResult.statusCode = HttpCode.UNKNOW_ERROR_CODE;
            httpResult.statusMessage = e.error.toString();
//            }
          }
          break;
        case DioExceptionType.badCertificate:
          // TODO: Handle this case.
          break;
        case DioExceptionType.connectionError:
          // TODO: Handle this case.
          break;
      }
      return httpResult;
    }

    Response response;
    try {
      if (httpMethod == HttpMethod.POST) {
        response = await _httpClient!.post(url,
            data: formData ?? bodyParams,
            onSendProgress: onSendprogressCallBack,
            onReceiveProgress: onReceiveProgressCallBack,
            cancelToken: token,
            options: Options(method: 'POST'));
//            .catchError((Object err) {
//          if (resultCallBack != null) {
//            resultCallBack.onError(catchError(err));
//          }
//          //response = catchError(err);
//        });
      } else {
        response = await _httpClient!.get(
          url,
          cancelToken: token,
          options: Options(method: 'GET'),
        );
//            .catchError((Object err) {
//          if (resultCallBack != null) {
//            resultCallBack.onError(catchError(err));
//          }
//          //response = catchError(err);
//        });
      }
      httpResult.statusCode = response.statusCode;
      httpResult.statusMessage = response.statusMessage;
      httpResult.data = response.data;
    } on DioException catch (e) {
      httpResult = catchError(e);
    }
    return Future.value(httpResult);
  }
}
