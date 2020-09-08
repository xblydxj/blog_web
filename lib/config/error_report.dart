import 'package:flustars/flustars.dart';
import 'package:web/net/net.dart';

class ReportError {
  String error;
  String stacktrace;
  String uploadTime;

  static ReportError decorate(Object error, String stacktrace) {
    var reportError = ReportError();
    reportError.stacktrace = stacktrace;
    reportError.error = error.toString();
    reportError.uploadTime = DateUtil.formatDate(DateTime.now());
    return reportError;
  }

  report() => Net.instance
      .post(params: this.toJson(), path: '/business/exception')
      .catchError((error) => print(error));

  ReportError({
    this.error,
    this.stacktrace,
    this.uploadTime,
  });

  factory ReportError.fromJson(Map<String, dynamic> json) => ReportError(
      error: json['error'],
      stacktrace: json['stacktrace'],
      uploadTime: json['uploadTime']);

  Map<String, dynamic> toJson() => {
        "error": error,
        "stacktrace": stacktrace,
        "uploadTime": uploadTime,
      };
}
