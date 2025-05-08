import 'package:json_annotation/json_annotation.dart';

part 'responses.g.dart';

// Design the response of the api in this file
@JsonSerializable()
// We expect the response will be null because of this we add the ? to make it nullable
class BaseResponse {
  @JsonKey(name: "status") // her we write the name of the key in the response
  int? status;
  @JsonKey(name: "message")
  String? message;
}

@JsonSerializable()
class CustomerResponse // this sub response will be inside the authentication response
{
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "numberOfNotification")
  int? numberOfNotification;

  CustomerResponse(this.id, this.name, this.numberOfNotification);

  factory CustomerResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerResponseToJson(this);
}

@JsonSerializable()
class ContactsResponse // this sub response will be inside the authentication response
{
  @JsonKey(name: "phone")
  String? phone;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "link")
  String? link;

  ContactsResponse(this.phone, this.email, this.link);

  factory ContactsResponse.fromJson(Map<String, dynamic> json) =>
      _$ContactsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ContactsResponseToJson(this);
}

@JsonSerializable()
class AuthenticationResponse extends BaseResponse // this is the main response
{
  @JsonKey(name: "customer")
  CustomerResponse? customerResponse;
  @JsonKey(name: "contacts")
  ContactsResponse? contactsResponse;

  AuthenticationResponse(this.customerResponse, this.contactsResponse);

  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthenticationResponseToJson(this);
}

@JsonSerializable()
class ForgetPasswordResponse extends BaseResponse {
  @JsonKey(name: "support")
  String? support;

  ForgetPasswordResponse(this.support);

  factory ForgetPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ForgetPasswordResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ForgetPasswordResponseToJson(this);
}

/*
*  we created the AuthenticationResponse class to model a JSON response from an authentication API.
*  It extends BaseResponse to inherit common fields like status and message, while containing CustomerResponse and ContactsResponse as nested objects.
*  This structure matches the API’s nested JSON format, using composition to represent customer and contact data separately.
*  The @JsonSerializable() annotation enables automatic JSON serialization/deserialization for easy data handling.
*  It’s designed for type safety, reusability, and maintainability in processing authentication results.
*/
