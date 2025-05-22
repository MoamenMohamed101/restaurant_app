import 'package:dartz/dartz.dart';
import 'package:restaurant_app/data/network/failure.dart';
import 'package:restaurant_app/domain/model/models.dart';
import 'package:restaurant_app/domain/repository/repository.dart';
import 'package:restaurant_app/domain/usecase/base_usecase.dart';

class StoreDetailsUsecase extends BaseUseCase<void, StoreDetails> {
  final Repository _repository;

  StoreDetailsUsecase(this._repository);

  @override
  Future<Either<Failure, StoreDetails>> execute(void input)  {
    return _repository.getStoreDetails();
  }
}
