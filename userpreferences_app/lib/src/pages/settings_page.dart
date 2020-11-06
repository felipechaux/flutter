import 'package:flutter/material.dart';
import 'package:userpreferences_app/src/share_pref/user_preferences.dart';
import 'package:userpreferences_app/src/widgets/menu_widget.dart';

class SettingsPage extends StatefulWidget {
  static final routeName = 'settings';

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _secondaryColor;
  int _genere;
  String _name;

  TextEditingController _textController;

  //preferencias
  final prefs = new UserPreferences();

//disparar al inicializar el estado
  @override
  void initState() {
    super.initState();

    //loadPreferences();

    //preferencias

    prefs.lastPage = SettingsPage.routeName;

    _genere = prefs.genere;

    _secondaryColor = prefs.secondaryColor;

    _textController = new TextEditingController(text: prefs.userName);
  }

  //cargar preferencias
  /*loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _genere = prefs.getInt('genere');
    });
  }*/

  _setSelectedRadio(int value) {
    //uso de preferencias
    // SharedPreferences prefs = await SharedPreferences.getInstance();

    //guardar valor
    //prefs.setInt('genere', value);

    setState(() {
      //uso de preferencia
      prefs.genere = value;

      _genere = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
          backgroundColor: (prefs.secondaryColor) ? Colors.teal : Colors.blue,
        ),
        drawer: MenuWidget(),
        body: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(5.0),
              child: Text('Settings',
                  style:
                      TextStyle(fontSize: 45.0, fontWeight: FontWeight.bold)),
            ),
            Divider(),
            SwitchListTile(
              value: _secondaryColor,
              title: Text('Secundary color'),
              onChanged: (value) {
                setState(() {
                  _secondaryColor = value;

                  //modificacion en preferencias
                  prefs.secondaryColor = value;
                });
              },
            ),
            RadioListTile(
              value: 1,
              title: Text('Male'),
              groupValue: _genere,
              onChanged: _setSelectedRadio,
            ),
            RadioListTile(
                value: 2,
                title: Text('Female'),
                groupValue: _genere,
                onChanged: _setSelectedRadio),
            Divider(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: _textController,
                decoration: InputDecoration(
                    labelText: 'Name', helperText: 'Name of person'),
                onChanged: (value) {
                  prefs.userName = value;
                },
              ),
            )
          ],
        ));
  }
}
