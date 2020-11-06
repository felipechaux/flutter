import 'dart:async';
import 'package:inproext_app/src/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';

// mixin validators
class LoginBloc with Validators {
  String userName;
  //controller email
  //conversion para rxdart
  final _emailController = BehaviorSubject<String>();

  //controller password
  //conversion para rxdart
  final _passwordController = BehaviorSubject<String>();

  //recuperar datos de stream
  Stream<String> get emailStream =>
      _emailController.stream.asBroadcastStream().transform(validateEmail);

  Stream<String> get passwordStream => _passwordController.stream
      .asBroadcastStream()
      .transform(validatePassword);

//validacion formulario dos streams correctos
//nuevo stream para rxdart - uso de combined 2 por ser dos strings a mezclar
  Stream<bool> get formValidStream =>
      Rx.combineLatest2(emailStream, passwordStream, (e, p) => true)
          .asBroadcastStream();

  Stream<bool> get passwordValidStream =>
      Rx.combineLatest2(passwordStream, passwordStream, (e, p) => true)
          .asBroadcastStream();

//insertar valores al stream
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  //Obtener los ultimos valores de los streams
  String get email => _emailController.value;
  String get password => _passwordController.value;

  set email(String value) {}

  //cerrar
  dispose() {
    _emailController?.close();
    _passwordController?.close();
  }
}
