import 'package:restaurant_app/app/constants.dart';
import 'package:restaurant_app/app/extensions.dart';
import 'package:restaurant_app/data/response/responses.dart';
import 'package:restaurant_app/domain/models.dart';

// we use mapper to convert the response to domain model
extension CustomerResponseMapper on CustomerResponse? {
  Customer toDomain() {
    return Customer(
      this?.id.orEmpty() ?? Constants.empty,
      this?.name.orEmpty() ?? Constants.empty,
      this?.numberOfNotification.orZero() ?? Constants.zero,
    );
  }
}

extension ContactsResponseMapper on ContactsResponse? {
  Contacts toDomain() {
    return Contacts(
      this?.email.orEmpty() ?? Constants.empty,
      this?.phone.orEmpty() ?? Constants.empty,
      this?.link.orEmpty() ?? Constants.empty,
    );
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse? {
  Authentication toDomain() {
    // we use ?. to check if the object is null or not before converting it to domain model
    // if it's null, we return the default value
    return Authentication(this?.customerResponse.toDomain(), this?.contactsResponse.toDomain());
  }
}