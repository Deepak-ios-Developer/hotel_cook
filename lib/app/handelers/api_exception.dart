import 'dart:io';

import 'package:base_project/app/common_widgets/common_snackbar.dart';
import 'package:base_project/app/constants/app_strings.dart';
import 'package:base_project/app/constants/enums.dart';
import 'package:base_project/app/handelers/app_exceptions.dart';
import 'package:base_project/app/routes/app_routes.dart' show AppRoutes;
import 'package:base_project/app/storage/app_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ExceptionHandler {
  static AppException handleApiException(DioException e) {
    if (e.error.runtimeType == SocketException) {
      throw DataFetchException('No Internet');
    } else if (e.response?.statusCode == 400) {
      String? type = e.response?.data['error']['type'];
      String? message = e.response?.data['error']['message'];
      if (type == AppStrings.unauthorizedException ||
          message == AppStrings.unauthorizedException) {
        AppStorage().clearAll();
        message = AppStrings.tokenExpired;
      } else {
        message = e.response?.data['error']['message'];
      }

      throw BadRequestException(message ?? 'Bad Request');
    } else if (e.response?.statusCode == 401) {
      throw UnauthorizedException();
    } else if (e.response?.statusCode == 429) {
      throw TooManyRequestsException();
    } else if (e.response?.statusCode == 500) {
      throw InternalErrorException();
    } else {
      throw UnknownErrorException();
    }
  }

  static void handleUiException({
    required BuildContext context,
    required Status status,
    required String? message,
    bool? showDataNotFound,
    void Function()? onServerError,
  }) {
    if (status == Status.ERROR) {
      if (onServerError != null) {
        onServerError();
      }
      if ((message?.contains(AppStrings.unauthorizedException) ?? false) ||
          (message?.contains(AppStrings.tokenExpired) ?? false)) {
        showCommonSnackbar(context, message: 'Invalid Credentials');
        // Navigator.pushNamed(context, AppRoutes.login);
      } else if (message == AppStrings.errorNetwork) {
        //TODO: Design No internet page

        // context.goNamed(noInternetRoute);
        showCommonSnackbar(context, message: 'Invalid Credentials');
      } else if (showDataNotFound ?? true) {
        showCommonSnackbar(context, message: 'Invalid Credentials');
      }
    }
  }
}
