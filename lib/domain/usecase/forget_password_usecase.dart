import 'package:dartz/dartz.dart';
import 'package:restaurant_app/data/network/failure.dart';
import 'package:restaurant_app/domain/repository/repository.dart';
import 'package:restaurant_app/domain/usecase/base_usecase.dart';

class ForgetPasswordUsecase implements BaseUseCase<String, String> {
  final Repository _repository;

  ForgetPasswordUsecase(this._repository);

  @override
  Future<Either<Failure, String>> execute(String email) {
    return _repository.resetPassword(email);
  }
}
