import 'dart:async';

import 'package:formvalidationapp/src/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';

// mixin validators
class LoginBloc with Validators {
  //controller email
  //final _emailController = StreamController<String>.broadcast();
  //conversion para rxdart
  final _emailController = BehaviorSubject<String>();

  //controller password
  //final _passwordController = StreamController<String>.broadcast();
  //conversion para rxdart
  final _passwordController = BehaviorSubject<String>();

  //recuperar datos de stream
  Stream<String> get emailStream =>
      _emailController.stream.transform(validateEmail);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validatePassword);

//validacion formulario dos streams correctos
//nuevo stream para rxdart - uso de combined 2 por ser dos strings a mezclar
  Stream<bool> get formValidStream =>
      Rx.combineLatest2(emailStream, passwordStream, (e, p) => true);

//insertar valores al stream
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  //Obtenr los ultijmos valores de los streams
  String get email => _emailController.value;
  String get password => _passwordController.value;

  //cerrar
  dispose() {
    _emailController?.close();
    _passwordController?.close();
  }
}
