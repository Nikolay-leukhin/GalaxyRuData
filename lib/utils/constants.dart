part of 'utils.dart';

class AppStrings {
  static const String emailRegExp =
      r"^[a-zA-Z0-9._-]+@[a-zA-Z0-9._-]+\.[a-zA-Z]+";

  static const Duration serverOffset = Duration.zero;

  static const Map<String, dynamic> months = {
    '1': 'января',
    '2': 'февраля',
    '3': 'марта',
    '4': 'апреля',
    '5': 'мая',
    '6': 'июня',
    '7': 'июля',
    '8': 'августа',
    '9': 'сентября',
    '10': 'октября',
    '11': 'ноября',
    '12': 'декабря',
  };

  static const String obscuredText = '****';

  static const String nullText = 'null';

// static const Map<int, String> gender = {0: 'Мужчина', 1: "Женищина"};
}
