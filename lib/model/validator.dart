import 'package:get/get.dart';

class Validator extends GetxController {
  String? validateName({required String name}) {
    if (name == null) {
      return null;
    }
    if (name.isEmpty) {
      return "Debe digitar el nombre";
    }

    return null;
  }

  String? validateEmail({required String email}) {
    if (email == null) {
      return null;
    }

    RegExp emailRegExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

    if (email.isEmpty) {
      return "Debe digitar un email";
    } else if (!emailRegExp.hasMatch(email)) {
      return "Debe digitar un email valido";
    }

    return null;
  }

  String? validatePassword({required String password}) {
    if (password == null) {
      return null;
    }
    if (password.isEmpty) {
      return "Debe digitar un password";
    }
    if (password.length < 6) {
      return "El password debe ser minimo de 6 caracteres";
    }

    return null;
  }
}
