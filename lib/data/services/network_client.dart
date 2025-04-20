import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:to_do_application/app.dart';
import 'package:to_do_application/core/routes/routes_name.dart';
import 'package:to_do_application/core/utils/util_message.dart';
import 'package:to_do_application/data/services/network_response.dart';
import 'package:to_do_application/presentation/controllers/auth_controller.dart';

class NetworkClient {
  static Future<NetworkResponse> getRequest({required String url}) async {
    try {
      Uri uri = Uri.parse(url);
      Response response = await get(uri, headers: {'token': AuthController.token ?? ''});
      if (response.statusCode == 200) {
        final decodedJSON = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          data: decodedJSON,
        );
      } else if (response.statusCode == 401) {
        await _moveUserToLoginPage();
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        message: e.toString(),
      );
    }
  }

  static Future<NetworkResponse> postRequest({
    required String url,
    Map<String, dynamic>? body,
  }) async {
    try {
      Uri uri = Uri.parse(url);
      Response response = await post(
        uri,
        headers: {'Content-Type': 'application/json', 'token': AuthController.token ?? ''},
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        final decodedJSON = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          data: decodedJSON,
        );
      } else if (response.statusCode == 401) {
        await _moveUserToLoginPage();
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        message: e.toString(),
      );
    }
  }

  static Future<void> _moveUserToLoginPage() async {
    await AuthController.clearUserData();
    Utils.snackBar("Authorization Failed. Please Login Again.", TaskManagerApp.navigatorKey.currentContext!);
    Navigator.pushNamedAndRemoveUntil(
      TaskManagerApp.navigatorKey.currentContext!,
      RoutesName.login,
          (pre) => false,
    );
  }
}
