class Validators {
  static String? nameSurnameValidator(nameSurname) {
    if (nameSurname!.isEmpty) return 'Lütfen Ad Soyad Giriniz';
    return null;
  }

  static String? emailValidator(email) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    var regex = RegExp(pattern as String);
    if (email!.isEmpty) {
      // return 'Email boş bırakılamaz';
      return 'Bu alan boş bırakılamaz';
    } else if (!regex.hasMatch(email!)) {
      return 'Geçersiz Email';
    }
    return null;
  }

  static String? phoneValidator(String? phone) {
    // var regExp = RegExp('(0) [(](5)[0-9][0-9][)] ([0-9]){3} ([0-9]){2} ([0-9]){2}');

    // if (phone!.isEmpty) {
    //   return 'Lütfen Telefon Numarası Giriniz';
    // } else if (!regExp.hasMatch(phone)) {
    //   return 'Geçersiz Telefon Numarası';
    // }

    var regExp = RegExp('(05|5)[0-9][0-9][0-9]([0-9]){6,6}');
    if (phone!.isEmpty) {
      // return 'Bu alan boş bırakılamaz';
      return null;
    } else if (!regExp.hasMatch(phone)) {
      return 'Geçersiz Telefon Numarası';
    }
    return null;
  }

  static String? urlValidator(String? url) {
    var regExp = RegExp(
        '(https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|www\.[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9]+\.[^\s]{2,}|www\.[a-zA-Z0-9]+\.[^\s]{2,})');
    if (!regExp.hasMatch(url!)) {
      return 'Geçersiz Url';
    }
    return null;
  }

  static String? passwordValidator(String? password) {
    if (password!.isEmpty) {
      return 'Lütfen Şifre Giriniz';
    } else if (password.length < 8) {
      return 'Şifre en az 8 karakter olmalıdır';
    }
    return null;
  }


  static String? notEmpty(String? value) {
    if (value!.isEmpty) {
      return 'Bu alan boş bırakılamaz';
    }
    return null;
  }
}
