import 'package:json_annotation/json_annotation.dart';
part 'responses.g.dart';

@JsonSerializable() // to make from json and to json
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

  Map<String, dynamic> toJson() => _$CustomerResponseToJson(this); // this refer to the class
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

  Map<String, dynamic> toJson() => _$ContactsResponseToJson(this); // this refer to the class
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