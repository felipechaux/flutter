import 'dart:async';

class Validators {
  //entra string, sale string
  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length >= 6) {
      //valido - dejarlo fluir
      sink.add(password);
    } else {
      sink.addError('Digita mas de 6 caracteres');
    }
  });

  final validateEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(pattern);

    if (regExp.hasMatch(email)) {
      //correo valido
      sink.add(email);
    } else {
      sink.addError('El email no es correcto');
    }
  });
}
