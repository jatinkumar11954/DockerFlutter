String userNameValidation(String value) {
  if (value.isEmpty) {
    return "      Please Enter User Name";
  }
  if (value.length < 3)
    return 'User Name have minmum 3 charecters';
  else
    return null;
}

String addrValidation(String value) {
  if (value.isEmpty) {
    return "Please Enter Address Line";
  }
  if (value.length < 3)
    return 'Address have minmum 3 charecters';
  else
    return null;
}

String cityValidation(String value) {
  if (value.isEmpty) {
    return "Please Enter City";
  }
  if (value.length < 3)
    return 'City have minmum 3 charecters';
  else
    return null;
}

String editAddressValidation(String value) {
  if (value.length < 1)
    return '      Please enter this field';
  else
    return null;
}

//otpValidation
String otpValidation(String value) {
  if (value.length < 5)
    return 'otp should have 5 charecters';
  else
    return null;
}

String zipValidation(String value) {
  if (value.length < 6)
    return 'Pincode should have 6 charecters';
  else
    return null;
}

//password validation
String passwordValidation(String value) {
  if (value.length < 3) {
    return "Password should have atleast 6 charecters";
  } else {
    return null;
  }
}

//email validation
String emailValidation(String email) {
  bool emailValid = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
  if (email.isEmpty) {
    return "      Please Enter Email Adddress";
  }
  if (emailValid) {
    return null;
  } else {
    return "      Please Enter a valid Email";
  }
}

String phoneValidation(String Phone) {
  if (Phone.isEmpty) {
    return "      Please Enter Phone No";
  }
  if (Phone.length < 10) {
    return "      Phone number should be 10 digits";
  } else {
    return null;
  }
}

String passValidation(String Phone) {
  if (Phone.isEmpty) {
    return "      Please Enter Password";
  }
  if (Phone.length < 6) {
    return "      Password must be atleast 6 characters";
  } else {
    return null;
  }
}

String conpassValidation(String Phone, String pass) {
  if (Phone.isEmpty) {
    return "      Please Enter Password";
  }
  if (Phone.length < 6) {
    return "      Password must be atleast 6 characters";
  }
  if (Phone != pass) {
    return "      Password must match";
  } else {
    return null;
  }
}
