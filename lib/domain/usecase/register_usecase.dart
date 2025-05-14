import 'package:dartz/dartz.dart';
import 'package:restaurant_app/data/network/failure.dart';
import 'package:restaurant_app/data/network/requests.dart';
import 'package:restaurant_app/domain/model/models.dart';
import 'package:restaurant_app/domain/repository/repository.dart';
import 'package:restaurant_app/domain/usecase/base_usecase.dart';

class RegisterUseCase
    implements BaseUseCase<RegisterUseCaseInput, Authentication> {
  final Repository _repository;

  RegisterUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(
      RegisterUseCaseInput registerRequests) async {
    return await _repository.register(
      RegisterRequests(
        userName: registerRequests.userName,
        countryMobileCode: registerRequests.countryMobileCode,
        mobileNumber: registerRequests.mobileNumber,
        profilePicture: registerRequests.profilePicture,
        email: registerRequests.email,
        password: registerRequests.password,
      ),
    );
  }
}

class RegisterUseCaseInput {
  String userName,
      countryMobileCode,
      mobileNumber,
      email,
      password,
      profilePicture;

  RegisterUseCaseInput({
    required this.userName,
    required this.countryMobileCode,
    required this.mobileNumber,
    required this.email,
    required this.password,
    required this.profilePicture,
  });
}
