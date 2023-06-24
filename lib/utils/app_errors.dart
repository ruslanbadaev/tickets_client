import 'package:dio/dio.dart';

class AppErrors {
  static String parseNetworkError(DioError error) {
    String errorText = error.message;

    try {
      if (error.message.toUpperCase().contains('CONNECTION CLOSED')) {
        return 'CONNECTION_CLOSED';
      }
      if (error.message.toUpperCase().contains('CONNECTION REFUSED')) {
        return 'CONNECTION_REFUSED';
      }
      if (error.response.toString().toUpperCase().contains('UNAUTHORIZED')) {
        return 'UNAUTHORIZED';
      }
      return errorText;
    } catch (e) {
      return errorText;
    }
  }
}
