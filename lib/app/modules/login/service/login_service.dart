

  import 'package:base_project/app/handelers/api_exception.dart';
import 'package:base_project/app/modules/login/data/login_data.dart';
import 'package:base_project/app/routes/api_routes.dart';
import 'package:base_project/service/base_service.dart';
import 'package:dio/dio.dart' show DioException;
class LoginService {

Future<Map<String, dynamic>> login(LoginRequestData request) async {
    try {
      final response = await BaseService.dio.post(
        ApiRoutes.login,
        data:request.toJson(), 
        options: BaseService.headerWithToken(''),
      );
      return response.data;
    } on DioException catch (e) {
      throw ExceptionHandler.handleApiException(e);
    }
  }
}
