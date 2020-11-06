import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:inproext_app/src/bloc/provider.dart';
import 'package:inproext_app/src/providers/user_provider.dart';
import 'package:inproext_app/src/utils/constants.dart';

final userProvider = new UserProvider();
var passIcon = Image(image: AssetImage('assets/images/ico_show.png'));
bool _passwordVisible = false;

void showPasswordAlert(
    BuildContext context, LoginBloc bloc, GoogleSignInAccount user) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          titlePadding: EdgeInsets.symmetric(vertical: 6.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 230.0),
                child: IconButton(
                  iconSize: 40.0,
                  icon: Icon(Icons.close, color: Constants.colorRedInproext),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              Text('Ingresa tu contraseña',
                  style: TextStyle(
                      fontFamily: Constants.fontTitilliumWebLight,
                      fontSize: 23.0))
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _createPasswordRegisterGoogle(bloc),
              SizedBox(height: 35.0),
              _createButtonRegisterGoogle(bloc, user)
            ],
          ),
        );
      });
}

Widget _createPasswordRegisterGoogle(LoginBloc bloc) {
  return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (context, snapshot) {
        return Container(
          child: TextField(
              obscureText: true,
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
                  hintText: 'Contraseña',
                  hintStyle: TextStyle(
                      color: Colors.white,
                      fontFamily: Constants.fontTitilliumWebLight),
                  fillColor: Constants.colorBlueInproext,
                  filled: true,
                  errorStyle: TextStyle(color: Colors.grey),
                  errorText: snapshot.error),
              onChanged: (value) => {bloc.changePassword(value)}),
        );
      });
}

Widget _createButtonRegisterGoogle(LoginBloc bloc, GoogleSignInAccount user) {
  return StreamBuilder<Object>(
    stream: bloc.passwordValidStream,
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
          child: RaisedButton(
              //borde
              shape: StadiumBorder(),
              color: Constants.colorRedInproext,
              textColor: Colors.white,
              onPressed: snapshot.hasData
                  ? () => userProvider.registerGoogle(context, user, bloc)
                  : null,
              disabledColor: Constants.colorRedInproext,
              disabledTextColor: Colors.white,
              child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 56.0, vertical: 7.0),
                  child: Text('Ingresar',
                      style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: Constants.fontTitilliumWebLight)))));
    },
  );
}

showPassword() {
  if (_passwordVisible) {
    passIcon = Image(
        colorBlendMode: BlendMode.colorDodge,
        image: AssetImage('assets/images/ico_show.png'));

    _passwordVisible = false;
  } else {
    passIcon = Image(image: AssetImage('assets/images/ico_show.png'));

    _passwordVisible = true;
  }
}
