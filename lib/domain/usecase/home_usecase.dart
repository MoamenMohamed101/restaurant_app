import 'package:dartz/dartz.dart';
import 'package:restaurant_app/data/network/failure.dart';
import 'package:restaurant_app/domain/model/models.dart';
import 'package:restaurant_app/domain/repository/repository.dart';
import 'package:restaurant_app/domain/usecase/base_usecase.dart';

class HomeUsecase extends BaseUseCase<void, HomeObject>{
  final Repository _repository;
  HomeUsecase(this._repository);
  @override
  Future<Either<Failure, HomeObject>> execute(void input) async {
    return await _repository.getHomeData();
  }
}