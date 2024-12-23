import 'package:dartz/dartz.dart';
import 'package:restaurant_app/data/network/failure.dart';
import 'package:restaurant_app/data/network/requests.dart';
import 'package:restaurant_app/domain/model/models.dart';
import 'package:restaurant_app/domain/repository/repository.dart';
import 'package:restaurant_app/domain/usecase/base_usecase.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInput, Authentication> {
  final Repository _repository;
  LoginUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(LoginUseCaseInput input) async{
    return await _repository.login(LoginRequests(input.email, input.password));
  }
}

class LoginUseCaseInput {
  String email, password;
  LoginUseCaseInput(this.email, this.password);
}
