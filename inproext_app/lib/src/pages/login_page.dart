import 'dart:io';

import 'package:flutter/material.dart';
import 'package:inproext_app/src/bloc/provider.dart';
import 'package:inproext_app/src/providers/user_provider.dart';
import 'package:inproext_app/src/utils/constants.dart';
import 'package:inproext_app/src/utils/utils.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userProvider = new UserProvider();
  bool _passwordVisible = false;
  var passIcon = Image(image: AssetImage('assets/images/ico_not_show_eye.png'));

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: Stack(
          children: <Widget>[
            _backgroundLogin(context),
            _tabsForm(),
            TabBarView(
              children: [_tabLogin(context, bloc), _tabRegister(context, bloc)],
            ),
          ],
        ),
      ),
    );
  }

  Widget _backgroundLogin(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Image(
        //ocupar todo el espacio disponible
        fit: BoxFit.cover,
        image: AssetImage('assets/images/img_login.jpg'),
      ),
    );
  }

  Widget _createEmail(LoginBloc bloc) {
    final _screenSize = MediaQuery.of(context).size;

    return StreamBuilder(
        stream: bloc.emailStream,
        builder: (context, snapshot) {
          return Container(
            //no tan pegado a los bordes
            padding: EdgeInsets.symmetric(horizontal: _screenSize.width * 0.26),
            child: TextField(
              style: TextStyle(color: Colors.grey),
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(width: 3, color: Colors.red),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(width: 3, color: Colors.red),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(width: 3, color: Colors.red),
                  ),
                  hintText: 'Email',
                  hintStyle: TextStyle(
                      color: Colors.white,
                      fontFamily: Constants.fontPoppinnsRegular),
                  fillColor: Constants.colorBlueInproext,
                  filled: true,
                  errorStyle: TextStyle(color: Colors.grey),
                  errorText: snapshot.error),
              onChanged: (value) => bloc.changeEmail(value),
            ),
          );
        });
  }

  Widget _createPassword(LoginBloc bloc) {
    final _screenSize = MediaQuery.of(context).size;

    return StreamBuilder(
        stream: bloc.passwordStream,
        builder: (context, snapshot) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: _screenSize.width * 0.26),
            child: TextField(
                obscureText: !_passwordVisible,
                style: TextStyle(color: Colors.grey),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                      onTap: () {
                        showPassword();
                      },
                      child: passIcon,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(width: 3, color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(width: 3, color: Colors.red),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(width: 3, color: Colors.red),
                    ),
                    hintText: 'Contraseña',
                    hintStyle: TextStyle(
                        color: Colors.white,
                        fontFamily: Constants.fontPoppinnsRegular),
                    fillColor: Constants.colorBlueInproext,
                    filled: true,
                    errorStyle: TextStyle(color: Colors.grey),
                    errorText: snapshot.error),
                onChanged: (value) => bloc.changePassword(value)),
          );
        });
  }

  Widget _createButtonGoogle(LoginBloc bloc, bool isLogin) {
    return RaisedButton(
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide.none,
      ),
      onPressed: () {
        if (isLogin) {
          userProvider.loginGoogle(context, bloc, true);
        } else {
          userProvider.loginGoogle(context, bloc, false);
        }
      },
      child: Container(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
                //padding: EdgeInsets.symmetric(horizontal: 0),
                child: new Text(
              "Acceder con google",
              style: TextStyle(
                  fontFamily: Constants.fontPoppinnsRegular, fontSize: 14.0),
            )),
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              child: Image.asset(
                'assets/images/ico_google.png',
                height: 18.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _createButtonApple(LoginBloc bloc) {
    return RaisedButton(
      color: Colors.black,
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide.none,
      ),
      onPressed: () async {
        final credential = await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
        );
        userProvider.loginApple(context, credential, bloc);
      },
      child: Container(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
                child: new Text(
              "Acceder con Apple",
              style: TextStyle(
                  fontFamily: Constants.fontPoppinnsRegular,
                  fontSize: 14.0,
                  color: Colors.white),
            )),
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              child: Image.asset(
                'assets/images/ico_apple.png',
                height: 18.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _createButtonSign(LoginBloc bloc) {
    final _screenSize = MediaQuery.of(context).size;

    return StreamBuilder<Object>(
        stream: bloc.formValidStream,
        builder: (context, snapshot) {
          return RaisedButton(
            //borde
            shape: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide.none,
            ),
            color: Constants.colorRedInproext,
            textColor: Colors.white,
            onPressed: snapshot.hasData ? () => _login(bloc, context) : null,
            disabledColor: Constants.colorRedInproext,
            disabledTextColor: Colors.white,
            child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: _screenSize.width * 0.12, vertical: 10.0),
                child: Text('Ingresar',
                    style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: Constants.fontPoppinnsRegular))),
          );
        });
  }

  Widget _createButtonRegister(LoginBloc bloc) {
    final _screenSize = MediaQuery.of(context).size;

    return StreamBuilder<Object>(
        stream: bloc.formValidStream,
        builder: (context, snapshot) {
          return RaisedButton(
            //borde
            shape: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide.none,
            ),
            color: Constants.colorRedInproext,
            textColor: Colors.white,
            onPressed: snapshot.hasData ? () => _register(bloc, context) : null,
            disabledColor: Constants.colorRedInproext,
            disabledTextColor: Colors.white,
            child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: _screenSize.width * 0.09, vertical: 10.0),
                child: Text('Registrarse',
                    style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: Constants.fontPoppinnsRegular))),
          );
        });
  }

  _login(LoginBloc bloc, BuildContext context) async {
    //obtiene ultimo email y password enviado
    print('________________');
    print('Email: ${bloc.email}');
    print('Password: ${bloc.password}');
    print('________________');

    Map info = await userProvider.login(bloc.email, bloc.password);

    if (info['ok']) {
      bloc.userName = bloc.email;
      Navigator.pushReplacementNamed(context, 'home');
    } else {
      showAlert(context, 'Credenciales invalidas', 'Vuelve a intentarlo');
    }
  }

  _register(LoginBloc bloc, BuildContext context) async {
    final info = await userProvider.newUser(bloc.email, bloc.password);

    if (info['ok']) {
      Navigator.pushReplacementNamed(context, 'home');
    } else {
      showAlert(context, 'Error', 'Usuario existente');
    }
  }

  Widget _tabsForm() {
    return Container(
      padding: EdgeInsets.only(top: 125.0),
      margin: EdgeInsets.symmetric(horizontal: 40.0),
      child: TabBar(
        labelStyle: TextStyle(
            fontFamily: Constants.fontPoppinnsRegular, fontSize: 25.0),
        indicatorWeight: 2.0,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorColor: Constants.colorBlueInproext,
        unselectedLabelColor: Constants.colorBlueInproext,
        indicatorPadding: EdgeInsets.symmetric(horizontal: 20.0),
        isScrollable: false,
        tabs: [
          Tab(
            text: 'Ingreso',
          ),
          Tab(
            text: 'Registro',
          ),
        ],
      ),
    );
  }

  Widget _tabLogin(BuildContext context, LoginBloc bloc) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(height: size.height * 0.38),
          _createEmail(bloc),
          SizedBox(height: 10.0),
          _createPassword(bloc),
          SizedBox(height: 30.0),
          _createButtonSign(bloc),
          SizedBox(height: 14.0),
          _createButtonGoogle(bloc, true),
          SizedBox(height: 14.0),
          (Platform.isIOS) ? _createButtonApple(bloc) : Container(),
          SizedBox(height: 25.0),
        ],
      ),
    );
  }

  Widget _tabRegister(BuildContext context, LoginBloc bloc) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(height: size.height * 0.38),
          _createEmail(bloc),
          SizedBox(height: 10.0),
          _createPassword(bloc),
          SizedBox(height: 30.0),
          _createButtonRegister(bloc),
          SizedBox(height: 14.0),
          _createButtonGoogle(bloc, false),
          SizedBox(height: 25.0),
        ],
      ),
    );
  }

  showPassword() {
    if (_passwordVisible) {
      passIcon = Image(
          colorBlendMode: BlendMode.colorDodge,
          image: AssetImage('assets/images/ico_not_show_eye.png'));

      _passwordVisible = false;
    } else {
      passIcon = Image(image: AssetImage('assets/images/ico_show_eye.png'));

      _passwordVisible = true;
    }
    setState(() {});
  }
}
