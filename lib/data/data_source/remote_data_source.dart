import 'package:restaurant_app/data/network/app_api.dart';
import 'package:restaurant_app/data/network/requests.dart';
import 'package:restaurant_app/data/response/responses.dart';

// This is the abstract class for the remote data source that will be implemented in the data layer to get the data from the API.
abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequests loginRequests);
}

// This is the implementation of the remote data source.
class RemoteDataSourceImpl implements RemoteDataSource {
  final AppServicesClient _appServicesClient;

  RemoteDataSourceImpl(this._appServicesClient);

  @override
  Future<AuthenticationResponse> login(LoginRequests loginRequests) async {
    return await _appServicesClient.login(
      loginRequests.email,
      loginRequests.password,
    );
  }
}