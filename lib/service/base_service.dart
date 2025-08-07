import 'package:base_project/app/constants/enums.dart';
import 'package:base_project/app/constants/keys.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class BaseService {
  static final BaseOptions options = BaseOptions(
    baseUrl: dotenv.env['SERVER_URL'] ?? '',
    contentType: 'application/json',
  );

  static Dio dio = Dio(options);

  static Options headerWithToken(String token) {
    return Options(headers: {Keys.authToken: token});
  }
}

extension ApiStatusExtension on int {
  ApiStatus toApiStatus() {
    switch (this) {
      case 200:
        return ApiStatus.success200;
      case 400:
        return ApiStatus.error400;
      case 401:
        return ApiStatus.unauthorized401;
      case 404:
        return ApiStatus.notFound404;
      case 500:
        return ApiStatus.serverError500;
      default:
        return ApiStatus.unknown;
    }
  }
}
