import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
//singleto para solo una instancia
  static final UserPreferences _instance = new UserPreferences._internal();

  factory UserPreferences() {
    return _instance;
  }

  UserPreferences._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

//Ninguna de estas propiedades se usa
  //bool _secundaryColor;
  //int _genere;
  //String _name;

//GET Y SET del genero

  get genere {
    //?? si no existe genero, por defecto sera 1
    return _prefs.getInt('genere') ?? 1;
  }

  set genere(int value) {
    _prefs.setInt('genere', value);
  }

//GET Y SET del color secundario

  get secondaryColor {
    return _prefs.getBool('secondaryColor') ?? false;
  }

  set secondaryColor(bool value) {
    _prefs.setBool('secondaryColor', value);
  }

//GET Y SET del nombre de usuario

  get userName {
    return _prefs.getString('userName') ?? '';
  }

  set userName(String value) {
    _prefs.setString('userName', value);
  }

//GET Y SET de la ultima pagina

  get lastPage {
    return _prefs.getString('lastPage') ?? 'home';
  }

  set lastPage(String value) {
    _prefs.setString('lastPage', value);
  }
}
