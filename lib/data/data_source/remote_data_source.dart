import 'package:restaurant_app/data/network/app_api.dart';
import 'package:restaurant_app/data/network/requests.dart';
import 'package:restaurant_app/data/response/responses.dart';

// It's interacts directly with the remote APIs (e.g., REST endpoints)
// We make it return AuthenticationResponse because of this we make it in data layer
abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequests loginRequests);

  Future<AuthenticationResponse> register(RegisterRequests registerRequests);

  Future<ForgetPasswordResponse> resetPassword(String email);
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

  @override
  Future<ForgetPasswordResponse> resetPassword(String email) async {
    return await _appServicesClient.resetPassword(email);
  }

  @override
  Future<AuthenticationResponse> register(
      RegisterRequests registerRequests) async {
    return await _appServicesClient.register(
      registerRequests.userName,
      registerRequests.countryMobileCode,
      registerRequests.mobileNumber,
      "",
      registerRequests.email,
      registerRequests.password,
    );
  }
}
