import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../shared/constants.dart';

class DioHelper {
  static Dio dio;

  static init() {
    dio = Dio(BaseOptions(
      baseUrl: kBaseURL,
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> getData({
    @required String url,
    Map<String, dynamic> query,
    String username = 'api',
    String password = 'fzV(v6*H0p0TkigB^Gp9AeD&',
  }) async {
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    return await dio.get(url,
        queryParameters: query,
        options: Options(
        headers: <String, String>{'authorization': basicAuth}),);
  }

  static Future<Response> postData({
    String url,
    Map<String, dynamic> query,
    @required var data,
  String username = 'api',
  String password = 'fzV(v6*H0p0TkigB^Gp9AeD&',

  }) async {
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    return dio.post(
      url,
      queryParameters: query,
      data: data,
      options: Options(
          headers: <String, String>{'authorization': basicAuth}),
    );
  }
}