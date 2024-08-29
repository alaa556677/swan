import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

import '../app_constatnts/enum_constants.dart';
import '../url_constants.dart';
import 'cache_helper.dart';

class DioHelper {
  // static Dio? _dio;
  // static DioHelper? _instance;
  static Dio? dio;
////////////////////////////////////////////////////////////////////////////////
  static init() {
    dio = Dio(_getOptions());
    return null;
  }
  // static init() {
  //   dio = Dio(
  //     BaseOptions(
  //         baseUrl: UrlConstants.baseurl,
  //         receiveDataWhenStatusError: true,
  //         headers: {
  //           'Authorization': "Bearer ${CacheHelper.getData(key: Constants.token.toString())}",
  //         }),
  //   );
  // }
////////////////////////////////////////////////////////////////////////////////
//   static Dio? get dio => _dio;
////////////////////////////////////////////////////////////////////////////////
//   static void setDioAgain() {
//     _dio = Dio(_getOptions());
//   }
////////////////////////////////////////////////////////////////////////////////
  static BaseOptions _getOptions() {
    BaseOptions options = BaseOptions(
      followRedirects: false,
      validateStatus: (status) => status! <= 500,
    );
    options.connectTimeout = const Duration(seconds: 10); //10 sec
    options.receiveTimeout = const Duration(seconds: 20 ); //20 sec
    options.baseUrl = UrlConstants.baseurl;
    options.headers = {
      'access_token': "${CacheHelper.getData(key: Constants.token.toString())}",
    };
    options.queryParameters = {};
    return options;
  }
////////////////////////////////////////////////////////////////////////////////
  static Future<Response> getData({
    @required String? url,
    @required Map<String, dynamic>? query,
  }) async {
    return await dio!.get(
      url!,
      queryParameters: query,
    );
  }
////////////////////////////////////////////////////////////////////////////////
  static Future<Response> postData({
    @required String? url,
    @required dynamic data,
    String? token,
    Map<String, dynamic>? query,
  }) async {
    return await dio!.post(
      url!,
      queryParameters: query,
      data: data,
    );
  }
////////////////////////////////////////////////////////////////////////////////
  static Future<Response> putData({
    @required String? url,
    @required dynamic data,
    String? token,
    Map<String, dynamic>? query,
  }) async {
    return await dio!.put(
      url!,
      queryParameters: query,
      data: data,
    );
  }
////////////////////////////////////////////////////////////////////////////////
  static Future<Response> deleteData({
    @required String? url,
    Map<String, dynamic>? query,
  }) async {
    return await dio!.delete(
      url!,
      queryParameters: query,
    );
  }
////////////////////////////////////////////////////////////////////////////////
}