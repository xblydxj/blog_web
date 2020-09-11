import 'dart:convert';

import 'package:dio/dio.dart';

class HttpLogInterceptor extends Interceptor {
  var startTime;
  var endTime;

  @override
  Future onError(DioError err) {
    print("--------------------------------------");
    print("请求错误：");
    print("   - 错误信息：${err.message} ");
    print("   - 错误响应：${err.response} ");
    print("   - 错误内容：${err.error} ");
    print("--------------------------------------");
    return super.onError(err);
  }

  @override
  Future onRequest(RequestOptions options) {
    startTime = DateTime.now().millisecondsSinceEpoch;
    print("--------------------------------------");
    print("请求开始：");
    print("- 请求地址：${options.baseUrl}${options.path}");
    print("- 请求头： ");
    options.headers.forEach((key, v) => print('   $key ：$v'));
    print("- 请求方式：${options.method} ");
    print("- 请求参数：${options.data} ");
    if (options.data is String) json.encode(options.data);
    return super.onRequest(options);
  }

  @override
  Future onResponse(Response response) {
    print("请求响应：");
    print("- 响应状态：${response.statusCode}");
    print("- 耗时：${DateTime.now().millisecondsSinceEpoch - startTime}");
    print("- 响应参数：${response.data}");
    return super.onResponse(response);
  }
}
