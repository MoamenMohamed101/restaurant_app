// Base case has input that will come from view model in presentation layer and output that will be returned to view model from data layer
import 'package:dartz/dartz.dart';
import 'package:restaurant_app/data/network/failure.dart';

abstract class BaseUseCase <In,Out>{
  Future<Either<Failure,Out>> execute(In input);
}