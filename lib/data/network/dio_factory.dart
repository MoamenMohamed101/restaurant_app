import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:restaurant_app/app/app_pref.dart';
import 'package:restaurant_app/app/constants.dart';

const String APPLICATON_JSON = "application/json";
const String CONTENT_TYPE = "content-type";
const String ACCEPT = "accept";
const String AUTHORIZATION = "authorization";
const String LANGUAGE = "language";

class DioFactory {
  final AppPreferences _appPreferences;

  DioFactory(this._appPreferences);

  Future<Dio> getDio() async {
    Dio dio = Dio();
    String language = await _appPreferences.getAppLanguage();

    Map<String, String> header = {
      CONTENT_TYPE: APPLICATON_JSON,
      ACCEPT: APPLICATON_JSON,
      AUTHORIZATION: Constants.token,
      LANGUAGE: language,
    };
    dio.options = BaseOptions(
      headers: header,
      receiveDataWhenStatusError: false,
      baseUrl: Constants.baseUrl,
      sendTimeout: const Duration(seconds: Constants.timeout),
      receiveTimeout: const Duration(seconds: Constants.timeout),
    );
    // Add logger in debug mode only to log the request and response
    if (kReleaseMode) {
      print("release mode no logs");
    } else {
      dio.interceptors.add(
        PrettyDioLogger(
            requestHeader: true, requestBody: true, responseHeader: true),
      );
    }
    return dio;
  }
}

/*
sendTimeout: This sets the maximum time Dio will wait while sending data to the server. If the data isn't completely sent within this timeframe, a timeout error occurs.

receiveTimeout: This sets the maximum time Dio will wait to receive a response from the server after a request is sent. If the response isn't fully received within this period, a timeout error occurs.
* */
