extension EmailValidator on String? {

  bool isValidEmail() {
    return this != null && RegExp(r'\S+@\S+\.\S+').hasMatch(this!);
  }

}