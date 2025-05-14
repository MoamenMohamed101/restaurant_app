import 'package:dartz/dartz.dart';
import 'package:restaurant_app/data/data_source/remote_data_source.dart';
import 'package:restaurant_app/data/mapper/mapper.dart';
import 'package:restaurant_app/data/network/error_handler.dart';
import 'package:restaurant_app/data/network/failure.dart';
import 'package:restaurant_app/data/network/network_info.dart';
import 'package:restaurant_app/data/network/requests.dart';
import 'package:restaurant_app/data/response/responses.dart';
import 'package:restaurant_app/domain/model/models.dart';
import 'package:restaurant_app/domain/repository/repository.dart';

// class RepositoryImpl extends Repository {
//   final RemoteDataSource
//       _remoteDataSource; // Used to get the response from the remote data source
//   final NetworkInfo _networkInfo; // The network info
//
//   RepositoryImpl(this._remoteDataSource, this._networkInfo);
//
//   @override
//   Future<Either<Failure, Authentication>> login(
//     LoginRequests loginRequests,
//   ) async {
//     if (await isConnected()) {
//       try {
//         final AuthenticationResponse response = await _remoteDataSource.login(loginRequests);
//         // check if the response is successful
//         if (isSuccessful(response)) {
//           return Right(
//             response.toDomain(),
//           ); // Using mapper to convert the response to dart model
//         }
//         // if the response is not successful then return the failure message from the response
//         else {
//           return Left(
//             Failure(
//               ApiInternalStatus.failure,
//               response.message ?? ResponseMessage.defaultError,
//             ),
//           );
//         }
//       } catch (error) {
//         return Left(ErrorHandler.handel(error).failure);
//       }
//     } else {
//       return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
//     }
//   }
//
//   bool isSuccessful(AuthenticationResponse response) => response.status == ApiInternalStatus.success;
//
//   Future<bool> isConnected() async => await _networkInfo.isConnected;
// }

class RepositoryImpl extends Repository {
  final RemoteDataSource
      _remoteDataSource; // Used to get the response from the remote data source
  final NetworkInfo _networkInfo; // The network info

  RepositoryImpl(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequests loginRequests) async {
    if (await isConnected()) {
      return await _handleLoginRequest(loginRequests);
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  // Checks if the device is connected to the internet
  Future<bool> isConnected() async => await _networkInfo.isConnected;

  // Handles the login API request and response processing
  Future<Either<Failure, Authentication>> _handleLoginRequest(
      LoginRequests loginRequests) async {
    try {
      final AuthenticationResponse response =
          await _remoteDataSource.login(loginRequests);
      return _processLoginResponse(response);
    } catch (error) {
      return Left(ErrorHandler.handel(error).failure);
    }
  }

  // Processes the API response and determines success or failure
  Either<Failure, Authentication> _processLoginResponse(
      AuthenticationResponse response) {
    if (isSuccessfulAuthentication(response)) {
      return Right(response.toDomain()); // Convert to domain model
    } else {
      return Left(_createFailureFromAuthenticationResponse(response));
    }
  }

  // Checks if the response indicates a successful operation
  bool isSuccessfulAuthentication(AuthenticationResponse response) =>
      response.status == ApiInternalStatus.success;

  // Creates a Failure object from an unsuccessful response
  Failure _createFailureFromAuthenticationResponse(
      AuthenticationResponse response) {
    return Failure(
      ApiInternalStatus.failure,
      response.message ?? ResponseMessage.defaultError,
    );
  }

  @override
  Future<Either<Failure, String>> resetPassword(String email) async {
    if (await isConnected()) {
      return await _handleForgetPasswordRequest(email);
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  Future<Either<Failure, String>> _handleForgetPasswordRequest(
      String email) async {
    try {
      final ForgetPasswordResponse response =
          await _remoteDataSource.resetPassword(email);
      return _processForgetPasswordResponse(response);
    } catch (error) {
      return Left(ErrorHandler.handel(error).failure);
    }
  }

  Either<Failure, String> _processForgetPasswordResponse(
      ForgetPasswordResponse response) {
    if (isSuccessReset(response)) {
      return Right(response.toDomain());
    } else {
      return Left(_createFailureFromForgetPasswordResponse(response));
    }
  }

  bool isSuccessReset(ForgetPasswordResponse response) =>
      response.status == ApiInternalStatus.success;

  Failure _createFailureFromForgetPasswordResponse(
      ForgetPasswordResponse response) {
    return Failure(
      ApiInternalStatus.failure,
      response.message ?? ResponseMessage.defaultError,
    );
  }

  @override
  Future<Either<Failure, Authentication>> register(
      RegisterRequests registerRequests) async {
    if (await isConnected()) {
      return await _handleRegisterRequest(registerRequests);
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  Future<Either<Failure, Authentication>> _handleRegisterRequest(
      RegisterRequests registerRequests) async {
    try {
      final AuthenticationResponse response =
          await _remoteDataSource.register(registerRequests);
      return _processRegisterResponse(response);
    } catch (error) {
      return Left(ErrorHandler.handel(error).failure);
    }
  }

  Either<Failure, Authentication> _processRegisterResponse(
      AuthenticationResponse response) {
    if (isSuccessfulAuthentication(response)) {
      return Right(response.toDomain());
    } else {
      return Left(_createFailureFromAuthenticationResponse(response));
    }
  }
}
