import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:web/config/constants.dart';
import 'package:web/widgets/tips.dart';

import 'interceptors.dart';

typedef void OnSuccess(Map<String, dynamic> data);
typedef void OnFailed(String msg);

class Net {
  static Net _net;
  static Dio _dio;

  Net._() {
    _dio = Dio();
  }

  static Net get instance => _net ??= Net._();

  Net build({String baseUrl, headers, needEncrypt = true, needDecrypt = true}) {
    _dio.options
      ..baseUrl = baseEndpoint
      ..connectTimeout = 60000
      ..connectTimeout = 60000
      ..receiveTimeout = 60000
      ..sendTimeout = 60000;
    _dio.interceptors.clear();
    _dio.interceptors.add(HttpLogInterceptor());
    return instance;
  }

  Future post(
      {String path,
      OnSuccess onSuccess,
      Map<String, dynamic> params,
      OnFailed onFailed,
      bool needLoading = false,
      Function onComplete}) async {
    try {
      if (needLoading) Tip.instance.loading(barrierDismissible: false);
      Response<Map<String, dynamic>> response =
          await _dio.post(path, data: json.encode(params));
      BaseResponse baseResponse = BaseResponse.fromJson(response.data);
      if (baseResponse.code == 0 && onSuccess != null) {
        if (needLoading) Tip.instance.dismiss();
        return onSuccess(baseResponse.result);
      } else if (baseResponse.code != 0) {
        if (needLoading) Tip.instance.dismiss();
        if (onFailed != null) return onFailed(baseResponse.message);
      }
      if (needLoading) Tip.instance.dismiss();
    } on DioError catch (dioError) {
      print(dioError);
      if (needLoading) Tip.instance.dismiss();
      return BaseResponse(code: 101, message: dioError.message);
    } catch (e, s) {
      print("未知异常出错：$e\n$s");
      if (needLoading) Tip.instance.dismiss();
      return BaseResponse(code: 999, message: e.message);
    } finally {
      if (needLoading) Tip.instance.dismiss();
      if (onComplete != null) onComplete();
    }
  }
}

BaseResponse baseResponseFromJson(String str) =>
    BaseResponse.fromJson(json.decode(str));

String baseResponseToJson(BaseResponse data) => json.encode(data.toJson());

class BaseResponse {
  BaseResponse({
    this.code,
    this.message,
    this.result,
  });

  int code;
  String message;
  Map<String, dynamic> result;

  factory BaseResponse.fromJson(Map<String, dynamic> json) => BaseResponse(
        code: json["code"],
        message: json["message"],
        result: json["result"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "result": result,
      };
}
