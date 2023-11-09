import 'package:galaxy_rudata/utils/utils.dart';

abstract class Validator {
  static emailValidator(String? value) {
    if (!RegExp(AppStrings.emailRegExp).hasMatch((value ?? "").trim()) ||
        (value ?? "").isEmpty) {
      return 'Неверный email';
    } else {
      return null;
    }
  }

  static validatePassword(value) {
    if (value.length < 3) {
      return 'Слишком короткий';
    }

    return null;
  }

  static checkEquality(String one, String two) {
    return one == two;
  }

  static nameValidator(String name) {
    if (name.length >= 3) {
      return null;
    } else {
      return 'Длина имени должна быть больше трех';
    }
  }

  static verifyCodeValidator(String name) {
    if (name.length == 6) {
      return null;
    } else {
      return 'Код неверной длины';
    }
  }

  static verifyPhone(String phone) {
    if (phone.length < 12) {
      return "Слишком короткий";
    }

    if (phone.length > 14) {
      return "Слишком длинный";
    }

    if (phone.substring(0, 1) != '+') {
      return "Номер начинается с +";
    }
  }

  static code(String code) {
    return code.length != 6 ? "Неправильный формат кода" : null;
  }
}
