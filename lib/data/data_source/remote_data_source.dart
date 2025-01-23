import 'package:restaurant_app/data/network/app_api.dart';
import 'package:restaurant_app/data/network/requests.dart';
import 'package:restaurant_app/data/response/responses.dart';

// It's interacts directly with the remote APIs (e.g., REST endpoints)
// We make it return AuthenticationResponse because of this we make it in data layer
abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequests loginRequests);
}

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