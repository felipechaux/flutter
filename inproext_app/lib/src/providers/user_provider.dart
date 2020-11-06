import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:inproext_app/src/bloc/login_bloc.dart';
import 'package:inproext_app/src/preferences/user_preferences.dart';
import 'package:inproext_app/src/utils/utils.dart';
import 'package:inproext_app/src/widgets/dialog_password_widget.dart';

class UserProvider {
  final String _firebaseToken = 'AIzaSyBLfRq3wd3URrz-SE27X7dkU7gUFAPQHhQ';
  final _prefs = new UserPreferences();
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  static FirebaseAuth _auth = FirebaseAuth.instance;

  Future<Map<String, dynamic>> login(String email, String password) async {
    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final resp = await http.post(
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_firebaseToken',
        body: json.encode(authData));

    Map<String, dynamic> decodeResp = json.decode(resp.body);
    print(decodeResp);

    if (decodeResp.containsKey('idToken')) {
      _prefs.token = decodeResp['idToken'];
      //salvar token
      return {'ok': true, 'token': decodeResp['idToken']};
    } else {
      return {'ok': false, 'message': decodeResp['error']['message']};
    }
  }

  Future<Map<String, dynamic>> newUser(String email, String password) async {
    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final resp = await http.post(
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseToken',
        body: json.encode(authData));

    Map<String, dynamic> decodeResp = json.decode(resp.body);
    print(decodeResp);

    if (decodeResp.containsKey('idToken')) {
      _prefs.token = decodeResp['idToken'];
      //salvar token
      return {'ok': true, 'token': decodeResp['idToken']};
    } else {
      return {'ok': false, 'message': decodeResp['error']['message']};
    }
  }

  registerGoogle(
      BuildContext context, GoogleSignInAccount user, LoginBloc bloc) async {
    print('________________');
    print('Email: ${user.email}');
    print('Password: ${bloc.password}');
    print('________________');

    final info = await newUser(user.email, bloc.password);

    if (info['ok']) {
      bloc.userName = user.displayName;
      Navigator.pushReplacementNamed(context, 'home');
    } else {
      await logoutGoogle(context);
      showAlert(context, 'Error', 'Usuario existente');
    }
  }

  loginGoogle(BuildContext context, LoginBloc bloc, bool isLogin) async {
    try {
      GoogleSignInAccount account = await _googleSignIn.signIn();

      if (account != null) {
        if (isLogin) {
          var res = await _auth.signInWithCredential(
              GoogleAuthProvider.credential(
                  idToken: (await account.authentication).idToken,
                  accessToken: (await account.authentication).accessToken));

          final getToken = await res.user.getIdTokenResult();

          print(getToken.token);
          _prefs.token = getToken.token;
          bloc.userName = _googleSignIn.currentUser.displayName;
          Navigator.pushReplacementNamed(context, 'home');
        } else {
          showPasswordAlert(context, bloc, account);
        }
      }
    } catch (err) {
      print(err);
    }
  }

  logoutGoogle(BuildContext context) async {
    await _googleSignIn.signOut();
    Navigator.pushReplacementNamed(context, 'login');
  }
}
