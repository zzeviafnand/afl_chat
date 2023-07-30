import 'package:logger/logger.dart';

var logger = Logger(
  printer: PrettyPrinter(colors: false),
);

//regex validate email
String? emailValidator(String? value) {
  if (value == null || value.isEmpty) {
    return "Please enter email";
  } else if (!RegExp(
          r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$')
      .hasMatch(value)) {
    return "Please enter valid email";
  }
  return null;
}

// regex validate 6 digit number otp, integer
String? otpValidator(String? value) {
  if (value == null || value.isEmpty) {
    return "Please enter 6 digit number";
  } else if (!RegExp(r'^[0-9]+').hasMatch(value)) {
    return "Please enter 6 digit number";
  }
  return null;
}
