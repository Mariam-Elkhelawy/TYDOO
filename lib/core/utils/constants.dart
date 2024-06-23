class Constants {
  static const String baseURL = 'https://api.edamam.com';
  static const String appId = 'b4452ef2';
  static const String appKey = 'cc258a63219b1c10b753836b19d0dd60';
  static const String emailReg =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  static const String passwordReg =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  static const String phoneReg = r'^(?:[+0]2)?01[0125][0-9]{8}$';
}
