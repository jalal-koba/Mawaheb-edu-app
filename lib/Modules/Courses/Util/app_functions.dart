class AppFunctions {
  static bool isValidEmail(String email) {
    final RegExp emailRegExp = RegExp(
      r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
    );

    return emailRegExp.hasMatch(email);
  }

  static bool isValidPhoneNumber(String phone) {
    final RegExp phoneRegExp = RegExp(
      r'^\+?[0-9]{9,15}$',
    );
    return phoneRegExp.hasMatch(phone);
  }

  static bool isValidDate(String date) {
    final RegExp dateRegExp1 =
        RegExp(r'^(?:19|20)\d\d-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01])$');

    // date = "2000-12-20";

    return dateRegExp1.hasMatch(date);
  }
}
