//inheritedWidget personalizardo
//para compartir la informacion globalmente de forma eficiente

import 'package:flutter/material.dart';
import 'package:formvalidationapp/src/bloc/login_bloc.dart';
//export loginbloc
export 'package:formvalidationapp/src/bloc/login_bloc.dart';
import 'package:formvalidationapp/src/bloc/products_bloc.dart';
export 'package:formvalidationapp/src/bloc/products_bloc.dart';

class Provider extends InheritedWidget {
  //misma instancia para formulario login
  final loginBLoc = LoginBloc();

  //nuevo bloc de productos
  final _producstBloc = ProductsBloc();

//mantener data de streams despues de hacer hot reaload
  static Provider _instance;

  factory Provider({Key key, Widget child}) {
    if (_instance == null) {
      //crear nueva instancia
      _instance = new Provider._internal(key: key, child: child);
    }
    //si ya tenia instancia, se regresa
    return _instance;
  }
  //provider nuevo
  Provider._internal({Key key, Widget child}) : super(key: key, child: child);
//mantener data streams despues de hacer hot reaload - finish

  //normal
  //key - identificador uico del widget - almcacenar material app
  // Provider({Key key, Widget child}) : super(key: key, child: child);

  // al actualizarce debe notificar a hijos = true
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  //instancia de login - estado - arbol de widgets - buscar provider
  static LoginBloc of(BuildContext context) {
    //buscar instancia de bloc
    return context.dependOnInheritedWidgetOfExactType<Provider>().loginBLoc;
  }

  ///producstBloc- > publico
  static ProductsBloc producstBloc(BuildContext context) {
    //buscar instancia de bloc
    return context.dependOnInheritedWidgetOfExactType<Provider>()._producstBloc;
  }
}
