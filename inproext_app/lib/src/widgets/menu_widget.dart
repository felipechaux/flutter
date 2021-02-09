import 'package:flutter/material.dart';
import 'package:inproext_app/src/bloc/provider.dart';
import 'package:inproext_app/src/providers/user_provider.dart';
import 'package:inproext_app/src/utils/constants.dart';

class MenuWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    final userProvider = new UserProvider();
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(bottom: _screenSize.height * 0.63),
      child: ClipRRect(
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(30)),
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.only(left: 25.0),
            children: <Widget>[
              SizedBox(height: 20.0),
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Icon(
                    Icons.close,
                    color: Constants.colorRedInproext,
                    size: 60.0,
                  ),
                ),
              ),
              SizedBox(height: 70.0),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, 'home'),
                child: Text(
                  'Inicio',
                  style: (TextStyle(
                      color: Constants.colorBlack,
                      fontFamily: Constants.fontPoppinnsMedium,
                      fontSize: 20.0)),
                ),
              ),
              SizedBox(height: 8.0),
              Text(bloc.userName,
                  textAlign: TextAlign.start,
                  style: (TextStyle(
                      color: Constants.colorBlack,
                      fontFamily: Constants.fontPoppinnsLight,
                      fontSize: 20.0))),
              //  _notifications(),
              GestureDetector(
                onTap: () => userProvider.logoutGoogle(context),
                child: Text('Cerrar sesión',
                    style: (TextStyle(
                        color: Constants.colorBlack,
                        fontFamily: Constants.fontPoppinnsMedium,
                        fontSize: 20.0))),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _notifications() {
    return Padding(
      padding: EdgeInsets.only(right: 74.0),
      child: SwitchListTile(
        dense: true,
        activeTrackColor: Colors.grey,
        activeColor: Constants.colorBlueInproext,
        contentPadding: EdgeInsets.only(top: 1.0),
        value: true,
        title: Padding(
          padding: EdgeInsets.only(bottom: 6),
          child: Text('Notificaciones',
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Constants.colorBlueInproext,
                  fontFamily: Constants.fontTitilliumWebLight,
                  fontSize: 20.0)),
        ),
        onChanged: (value) => value,
      ),
    );
  }
}
