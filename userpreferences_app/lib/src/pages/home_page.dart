import 'package:flutter/material.dart';
import 'package:userpreferences_app/src/share_pref/user_preferences.dart';
import 'package:userpreferences_app/src/widgets/menu_widget.dart';

class HomePage extends StatelessWidget {
  static final routeName = 'home';
  //preferences
  final prefs = new UserPreferences();

  @override
  Widget build(BuildContext context) {
    prefs.lastPage = HomePage.routeName;

    return Scaffold(
        appBar: AppBar(
            title: Text('User preferences'), backgroundColor: Colors.red),
        drawer: MenuWidget(),
        body: Column(
          //informacion centrada
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Secundary color ${prefs.secondaryColor}'),
            Divider(),
            Text('Genere ${prefs.genere}'),
            Divider(),
            Text('Name ${prefs.userName}'),
            Divider(),
          ],
        ));
  }

/*
  Drawer _createMenu(BuildContext context) {

    return Drawer(
      child: ListView(
        //empezar list desde arriba
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
              child: Container(),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/menu-img.jpg'),
                      //todo ancho posible
                      fit: BoxFit.cover))),
          ListTile(
            leading: Icon(Icons.party_mode, color: Colors.blue),
            title: Text('Pages'),
            onTap: () =>
                Navigator.pushReplacementNamed(context, HomePage.routeName),
          ),
          ListTile(
            leading: Icon(Icons.party_mode, color: Colors.blue),
            title: Text('Party mode'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.people, color: Colors.blue),
            title: Text('People'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.settings, color: Colors.blue),
            title: Text('Settings'),
            onTap: () {
              //cerrar menu
              //  Navigator.pop(context);
              //cambia raiz - staks en pagina desaparecen
              Navigator.pushReplacementNamed(context, SettingsPage.routeName);
            },
          )
        ],
      ),
    );  
  }*/

}
