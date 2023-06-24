enum ResultStatus { error, success }

class ResultModel {
  final ResultStatus status;
  final String? message;
  final dynamic data;

  ResultModel({
    required this.status,
    this.message,
    this.data,
  });

  static String parseError(String? error) {
    return error ?? 'Ops! Something went wrong.';
  }

  static String parseSuccess(String? success) {
    return success ?? 'SUCCESS';
  }
}
