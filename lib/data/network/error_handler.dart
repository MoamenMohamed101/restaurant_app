import 'package:dio/dio.dart';
import 'package:restaurant_app/data/network/failure.dart';

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handel(dynamic error) {
    if (error is DioException) {
      failure = _handelError(error);
    } else {
      failure = DataSource.DEFAULT.getFailure();
    }
  }
}

Failure _handelError(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      return DataSource.CONNECT_TIMEOUT.getFailure();
    case DioExceptionType.sendTimeout:
      return DataSource.SEND_TIMEOUT.getFailure();
    case DioExceptionType.receiveTimeout:
      return DataSource.RECEIVE_TIMEOUT.getFailure();
    case DioExceptionType.badCertificate:
      return DataSource.BAD_REQUEST.getFailure();
    case DioExceptionType.badResponse:
      if (error.response!.statusCode != null &&
          error.response!.statusMessage != null && error.response != null) {
        return Failure(
          error.response!.statusCode!,
          error.response!.statusMessage!,
        );
      }else {
        return DataSource.DEFAULT.getFailure();
      }
    case DioExceptionType.cancel:
      return DataSource.CANCEL.getFailure();
    case DioExceptionType.connectionError:
      return DataSource.CONNECT_TIMEOUT.getFailure();
    case DioExceptionType.unknown:
      return DataSource.DEFAULT.getFailure();
  }
}

enum DataSource {
  SUCCESS,
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  UNAUTHORISED,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  CONNECT_TIMEOUT,
  CANCEL,
  RECEIVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
  DEFAULT,
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.SUCCESS:
        return Failure(ResponseCode.success, ResponseMessage.success);
      case DataSource.NO_CONTENT:
        return Failure(ResponseCode.noContent, ResponseMessage.noContent);
      case DataSource.BAD_REQUEST:
        return Failure(ResponseCode.badRequest, ResponseMessage.badRequest);
      case DataSource.FORBIDDEN:
        return Failure(ResponseCode.forbidden, ResponseMessage.forbidden);
      case DataSource.UNAUTHORISED:
        return Failure(ResponseCode.unauthorised, ResponseMessage.unauthorised);
      case DataSource.NOT_FOUND:
        return Failure(ResponseCode.noContent, ResponseMessage.notFound);
      case DataSource.INTERNAL_SERVER_ERROR:
        return Failure(ResponseCode.internalServerError,
            ResponseMessage.internalServerError);
      case DataSource.CONNECT_TIMEOUT:
        return Failure(
            ResponseCode.connectTimeout, ResponseMessage.connectTimeout);
      case DataSource.CANCEL:
        return Failure(ResponseCode.cancel, ResponseMessage.cancel);
      case DataSource.RECEIVE_TIMEOUT:
        return Failure(
            ResponseCode.receiveTimeout, ResponseMessage.receiveTimeout);
      case DataSource.SEND_TIMEOUT:
        return Failure(ResponseCode.sendTimeout, ResponseMessage.sendTimeout);
      case DataSource.CACHE_ERROR:
        return Failure(ResponseCode.cacheError, ResponseMessage.cacheError);
      case DataSource.NO_INTERNET_CONNECTION:
        return Failure(ResponseCode.noInternetConnection,
            ResponseMessage.noInternetConnection);
      case DataSource.DEFAULT:
        return Failure(ResponseCode.defaultError, ResponseMessage.defaultError);
    }
  }
}

class ResponseCode {
  static const int success = 200; // success with data
  static const int noContent = 201; // success with no content
  static const int badRequest = 400; // failure due to client error
  static const int unauthorised =
      401; // failure due to user not being authorised
  static const int forbidden = 403; // failure due to user being forbidden
  static const int internalServerError =
      500; // failure due to internal server error
  static const int notFound = 404; // failure due to not found

// local status codes
  static const int connectTimeout = -1;
  static const int cancel = -2;
  static const int receiveTimeout = -3;
  static const int sendTimeout = -4;
  static const int cancelError = -5;
  static const int cacheError = -6;
  static const int noInternetConnection = -7;
  static const int defaultError = -8;
}

class ResponseMessage {
  static const String success = "success with data";
  static const String noContent = "success with no content";
  static const String badRequest = "failure due to client error";
  static const String unauthorised = "failure due to user not being authorised";
  static const String forbidden = "failure due to user being forbidden";
  static const String internalServerError =
      "failure due to internal server error";
  static const String notFound = "failure due to not found";

// local status codes
  static const String connectTimeout = "Timeout Error, Try again later";
  static const String cancel = "Request Cancelled, Try again later";
  static const String receiveTimeout = "Timeout Error, Try again later";
  static const String sendTimeout = "Timeout Error, Try again later";
  static const String cancelError = "Timeout Error, Try again later";
  static const String cacheError = "Cache Error, Try again later";
  static const String noInternetConnection =
      "Please check your internet connection";
  static const String defaultError = "Something went wrong, Try again later";
}

class ApiInternalStatus{
  static const int success = 0;
  static const int failure = 1;
}