class Failure {
  int code; // 200,201,400,500 and so on
  String message; // error, success
  Failure(this.code, this.message);
}