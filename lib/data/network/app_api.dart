import 'package:dio/dio.dart';
import 'package:restaurant_app/app/constants.dart';
import 'package:restaurant_app/data/response/responses.dart';
import 'package:retrofit/retrofit.dart';

// import 'package:retrofit/error_logger.dart';
// import 'package:retrofit/http.dart';
part 'app_api.g.dart';

// Design the request of the api in this file
@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServicesClient {
  factory AppServicesClient(Dio dio, {String? baseUrl}) =
      _AppServicesClient; // redirecting factory constructor

  @POST("/customers/login") // the endpoint of authentication
  Future<AuthenticationResponse> login(
    @Field("email") String email,
    @Field("password") String password,
  );

  @POST("/customers/forgetPassword") // the endpoint of forget password
  Future<ForgetPasswordResponse> resetPassword(@Field("email") String email);

  @POST("/customers/register") // the endpoint of authentication
  Future<AuthenticationResponse> register(
      @Field("user_name") String userName,
      @Field("country_mobile_code") String countryMobileCode,
      @Field("mobile_number") String mobileNumber,
      @Field("email") String email,
      @Field("password") String password,
      @Field("profile_picture") String profilePicture,
      );
  
  @GET("/home")
  Future<HomeResponse> getHome();

  @GET("/storeDetails/1")
  Future<StoresDetailsResponse> getStoreDetails();
}

/*
 constructors create objects — they are special functions used to initialize and return an instance of a class.

 A redirecting factory constructor is a factory constructor that forwards (redirects) (إعادة توجيه) the object creation to another constructor.

 Instead of writing custom logic inside the factory body, you just redirect to another constructor.

 redirecting factory constructor tells Dart:
 👉 “When someone calls AppServicesClient(...), instead of creating an instance of AppServicesClient, create and return an instance of _AppServicesClient with the same arguments.”
 */
