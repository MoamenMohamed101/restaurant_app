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
      _remoteDataSource; // This is the instance of the RemoteDataSource class that will be used to get the data from the remote data source.
  final NetworkInfo
      _networkInfo; // This is the instance of the NetworkInfo class that will be used to check the internet connection.

  RepositoryImpl(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequests loginRequests) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.login(loginRequests);
        // check if the response is successful
        if (response.status == ApiInternalStatus.success) {
          return Right(response.toDomain());
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
      } catch (error){
        return Left(ErrorHandler.handel(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
