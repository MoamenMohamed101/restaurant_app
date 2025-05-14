// This model carry the parameters that we will send to the api to login
class LoginRequests {
  String email;
  String password;

  LoginRequests(this.email, this.password);
}

class RegisterRequests {
  String email;
  String password;
  String userName;
  String countryMobileCode;
  String mobileNumber;
  String profilePicture;

  RegisterRequests({
    required this.email,
    required this.password,
    required this.userName,
    required this.countryMobileCode,
    required this.mobileNumber,
    required this.profilePicture,
  });
}
