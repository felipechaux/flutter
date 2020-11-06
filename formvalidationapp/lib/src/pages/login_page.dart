import 'package:flutter/material.dart';
import 'package:formvalidationapp/src/bloc/login_bloc.dart';
import 'package:formvalidationapp/src/bloc/provider.dart';
import 'package:formvalidationapp/src/providers/user_provider.dart';
import 'package:formvalidationapp/src/utils/utils.dart';

class LoginPage extends StatelessWidget {
  final userProvider = new UserProvider();

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    return Scaffold(
        body: Stack(
      children: <Widget>[_createBackground(context), _loginForm(context)],
    ));
  }

  Widget _loginForm(BuildContext context) {
    //uso de provider bloc - se recupera instancia de loginbloc
    //final bloc = Provider.of(context);

    final size = MediaQuery.of(context).size;

    return Container();
    /*SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
              child: Container(
            //espacio de la barra hasta el elemento
            height: 180.0,
          )),
          Container(
            //separacion con background felipe chaux
            margin: EdgeInsets.symmetric(vertical: 30.0),
            //85% de pantalla
            width: size.width * 0.85,
            padding: EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
                //sombras
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3.0,
                      //mas abajo la sombra
                      offset: Offset(0.0, 5.0),
                      //mas blur la sombra
                      spreadRadius: 3.0)
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0)),
            child: Column(
              children: <Widget>[
                Text('Login', style: TextStyle(fontSize: 20.0)),
                SizedBox(height: 60.0),
                _createEmail(bloc),
                SizedBox(height: 30.0),
                _createPassword(bloc),
                SizedBox(height: 30.0),
                _createButton(bloc),
              ],
            ),
          ),
          FlatButton(
            child: Text('Create account'),
            onPressed: () =>
                Navigator.pushReplacementNamed(context, 'register'),
          ),
          SizedBox(height: 100.0),
        ],
      ),
    );*/
  }

  Widget _createEmail(LoginBloc bloc) {
    //uso de streambuilder para bloc
    return StreamBuilder(
        stream: bloc.emailStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
            //no tan pegado a los bordes
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  icon: Icon(Icons.alternate_email, color: Colors.deepPurple),
                  hintText: 'example@email.com',
                  labelText: 'Email address',
                  //redibujar dato de bloc
                  counterText: snapshot.data,
                  errorText: snapshot.error),
              //uso de changeEmail de bloc
              onChanged: (value) => bloc.changeEmail(value),
            ),
          );
        });
  }

  Widget _createPassword(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          //no tan pegado a los bordes
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                icon: Icon(Icons.lock_outline, color: Colors.deepPurple),
                labelText: 'Password',
                counterText: snapshot.data,
                //si tiene error el snapshot
                errorText: snapshot.error),
            onChanged: (value) => bloc.changePassword(value),
          ),
        );
      },
    );
  }

  Widget _createButton(LoginBloc bloc) {
    //formValidStream

    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
          //container para estilizar mejor
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            child: Text('Sign'),
          ),
          //forma de boton
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          elevation: 0.0,
          color: Colors.deepPurple,
          textColor: Colors.white,
          //logica de snapshot con rxdart
          onPressed: snapshot.hasData ? () => _login(bloc, context) : null,
        );
      },
    );
  }

  _login(LoginBloc bloc, BuildContext context) async {
    //obtiene ultimo email y password enviado

    /*  print('________________');
    print('Email: ${bloc.email}');
    print('Password: ${bloc.password}');
    print('________________');

    Map info = await userProvider.login(bloc.email, bloc.password);

    if (info['ok']) {
      Navigator.pushReplacementNamed(context, 'home');
    } else {
      showAlert(context, info['message']);
    }*/

    //navegacion quitando boton atras - sera nueva ruta
  }

  Widget _createBackground(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final purpleBackground = Container(
      //40% de pantalla
      height: size.height * 0.4,
      //todo ancho de pantalla
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: <Color>[
        Color.fromRGBO(63, 63, 156, 1.0),
        Color.fromRGBO(90, 70, 178, 1.0)
      ])),
    );

    //white circle
    final circle = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Color.fromRGBO(255, 255, 255, 0.05)),
    );

    return Stack(
      children: <Widget>[
        purpleBackground,
        Positioned(top: 90.0, left: 30.0, child: circle),
        Positioned(top: -40.0, right: -30.0, child: circle),
        Positioned(bottom: -50.0, right: -10.0, child: circle),
        Positioned(bottom: 120.0, right: 20.0, child: circle),
        Positioned(bottom: -10.0, left: -20.0, child: circle),
        Container(
          padding: EdgeInsets.only(top: 80.0),
          child: Column(
            children: <Widget>[
              Icon(Icons.person_pin_circle, color: Colors.white, size: 100.0),
              SizedBox(
                height: 10.0,
                //truco para ubicar contenido de columna en el centro
                width: double.infinity,
              ),
              Text(
                'Felipe Chaux',
                style: TextStyle(color: Colors.white, fontSize: 25.0),
              )
            ],
          ),
        )
      ],
    );
  }
}
