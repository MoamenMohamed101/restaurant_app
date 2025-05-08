import 'package:dartz/dartz.dart';
import 'package:restaurant_app/data/network/failure.dart';
import 'package:restaurant_app/data/network/requests.dart';
import 'package:restaurant_app/domain/model/models.dart';

// The return from api will be one of two things Authentication or Failure to handle this we will use Either
// We make it return Authentication object not AuthenticationResponse because we need to convert it to domain model
abstract class Repository {
  Future<Either<Failure, Authentication>> login(LoginRequests loginRequests);
  Future<Either<Failure, String>> resetPassword(String email);
}