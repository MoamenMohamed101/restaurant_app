// OnBoarding Models
class OnBoardingModel {
  String? title;
  String? description;
  String? image;

  OnBoardingModel(this.title, this.description, this.image);
}

// This model carry the data form view model to view
class OnBoardingSlidersViewObject {
  OnBoardingModel onBoardingModel;
  int numberOfSlides;
  int currentIndex;

  OnBoardingSlidersViewObject(
      this.onBoardingModel, this.numberOfSlides, this.currentIndex);
}

// Authentication Models
class Customer {
  String id;
  String name;
  int numberOfNotification;

  Customer(this.id, this.name, this.numberOfNotification);
}

class Contacts {
  String phone;
  String email;
  String link;

  Contacts(this.phone, this.email, this.link);
}

// string, double and int are primitive types so we don't need to make them nullable by default they are nullable in dart
// But when we have a custom object like (Customer,Contacts) we need to make it nullable by default it's not nullable in dart
class Authentication {
  Customer? customer;
  Contacts? contacts;

  Authentication(this.customer, this.contacts);
}
