import 'package:flutter/material.dart';

class ScrollPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //navegador entre paginas
        body: PageView(
      //scroll vertical
      scrollDirection: Axis.vertical,
      children: <Widget>[_pageOne(), _pageTwo(context)],
    ));
  }

  Widget _pageOne() {
    //widget encima de otro
    return Stack(
      children: <Widget>[_colorBackground(), _imageBackground(), _texts()],
    );
  }

  Widget _pageTwo(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Color.fromRGBO(108, 192, 218, 0.5),
      child: Center(
          child: RaisedButton(
              //borde
              shape: StadiumBorder(),
              color: Colors.blue,
              textColor: Colors.white,
              onPressed: () {
                Navigator.pushNamed(context, 'bottons');
              },
              child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                  child: Text('Welcome', style: TextStyle(fontSize: 20.0))))),
    );
  }

  Widget _colorBackground() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Color.fromRGBO(108, 192, 218, 0.5),
    );
  }

  Widget _imageBackground() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Image(
        //ocupar todo el espacio disponible
        fit: BoxFit.cover,
        image: AssetImage('assets/scroll-1.png'),
      ),
    );
  }

  Widget _texts() {
    final styleText = TextStyle(color: Colors.white, fontSize: 50.0);
    return SafeArea(
      child: Column(
        children: <Widget>[
          SizedBox(height: 20.0),
          Text('11th', style: styleText),
          Text('Wednesday', style: styleText),
          //estirar contenido, por defecto se centra
          Expanded(child: Container()),
          Icon(Icons.keyboard_arrow_down, size: 70.0, color: Colors.white)
        ],
      ),
    );
  }
}
