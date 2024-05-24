class CustomValidator {
  static String? validateRegisterForm(String? username, String? email,
      String? password, String? repeatPassword) {
    String? result;
    result = result ?? validateUsername(username);
    result = result ?? validateEmail(email);
    result = result ?? validatePassword(password);
    result = result ?? validateRepeatPassword(repeatPassword, password ?? '');

    return result;
  }

  static String? validateLoginForm(String? email, String? password) {
    String? result;
    result = result ?? validateFieldNotEmpty("Email", email);
    result = result ?? validateFieldNotEmpty("Password", password);

    return result;
  }

  static String? validateFieldNotEmpty(String? fieldName, String? value) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required.';
    }

    return null;
  }

  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return "Username is required.";
    }

    // if (value.length < 3) {
    //   return "Username must be at least 3 characters long.";
    // }
    //
    // if (value.contains(RegExp(r'[!@#$%^&*(),?":{}|<>]'))) {
    //   return "Username must not contain special characters.";
    // }

    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is required.";
    }

    final emailRegExp = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegExp.hasMatch(value)) {
      return "Invalid email address.";
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required.";
    }

    if (value.length < 6) {
      return "Password must be at least 6 characters long.";
    }

    if (!value.contains(RegExp(r'[A-Z]'))) {
      return "Password must contain at least one uppercase letter.";
    }

    if (!value.contains(RegExp(r'[0-9]'))) {
      return "Password must contain at least one number.";
    }

    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return "Password must contain at least special character.";
    }

    return null;
  }

  static String? validateRepeatPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return "Repeat password is required.";
    }

    if (value != password) {
      return "Passwords don't match.";
    }

    return null;
  }
}
