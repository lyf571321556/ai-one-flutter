import 'package:dio/dio.dart';

import '../dio/http_code.dart';

import 'package:ones_ai_flutter/platform/web/main_web.dart'
    if (dart.library.io) 'package:ones_ai_flutter/platform/mobile/main_mobile.dart';

class ErrorInterceptors extends InterceptorsWrapper {
  ErrorInterceptors();

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final bool connected = await isConnected();
    if (!connected) {
      handler.resolve(new Response(
          statusCode: HttpCode.INVALID_NETWORK_CODE, requestOptions: options));
      return;
    }
    super.onRequest(options, handler);
  }
}
