import 'package:dartz/dartz.dart';
import 'package:restaurant_app/data/data_source/remote_data_source.dart';
import 'package:restaurant_app/data/mapper/mapper.dart';
import 'package:restaurant_app/data/network/error_handler.dart';
import 'package:restaurant_app/data/network/failure.dart';
import 'package:restaurant_app/data/network/network_info.dart';
import 'package:restaurant_app/data/network/requests.dart';
import 'package:restaurant_app/domain/model/models.dart';
import 'package:restaurant_app/domain/repository/repository.dart';

class RepositoryImpl extends Repository {
  final RemoteDataSource
      _remoteDataSource; // Used to get the response from the remote data source
  final NetworkInfo _networkInfo; // The network info

  RepositoryImpl(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, Authentication>> login(
    LoginRequests loginRequests,
  ) async {
    if (await _networkInfo.isConnected) {
      // it's connected to the internet, it's safe to call the remote data source (API)
      try {
        // The AuthenticationResponse in response variable
        final response = await _remoteDataSource.login(loginRequests);
        // check if the response is successful
        if (response.status == ApiInternalStatus.success) {
          return Right(
            response.toDomain(),
          ); // Using mapper to convert the response to dart model
        }
        // if the response is not successful then return the failure message from the response
        else {
          return Left(
            Failure(
              ApiInternalStatus.failure,
              response.message ?? ResponseMessage.defaultError,
            ),
          );
        }
      } catch (error) {
        return Left(ErrorHandler.handel(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}