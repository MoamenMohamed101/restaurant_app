import 'package:dartz/dartz.dart';
import 'package:restaurant_app/data/network/failure.dart';
import 'package:restaurant_app/data/network/requests.dart';
import 'package:restaurant_app/domain/model/models.dart';

// This is the abstract class for the repository that will be implemented in the data layer to get the data from the remote data source.
abstract class Repository {
  Future<Either<Failure, Authentication>> login(LoginRequests loginRequests);
}