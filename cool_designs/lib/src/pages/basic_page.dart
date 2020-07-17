import 'package:flutter/material.dart';

class BasicPage extends StatelessWidget {
  final styleTitle = TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);

  final styleSubTitle = TextStyle(fontSize: 18.0, color: Colors.grey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //contenido mas estatico, se estira solo contenido -SingleChildScrollView - ajuste barra arriba dispositivo
        body: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _createImage(),
          _createContent(),
          _createActions(),
          _createText(),
          _createText(),
          _createText(),
          Center(
              child: RaisedButton(
            //borde
            shape: StadiumBorder(),
            color: Colors.blue,
            textColor: Colors.white,
            onPressed: () {
              Navigator.pushNamed(context, 'scroll');
            },
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
                child: Text('Next Design', style: TextStyle(fontSize: 20.0))),
          )),
          SizedBox(height: 40.0)
        ],
      ),
    ));
  }

  Widget _createImage() {
    return Image(
        image: NetworkImage(
            'https://image.winudf.com/v2/image/Y29tLmh1YWRvbmcuZmVuZ2ppbmcxX3NjcmVlbnNob3RzXzBfM2I2ZTkzNzU/screen-0.jpg?fakeurl=1&type=.jpg'));
  }

  Widget _createContent() {
    // al hacer rotacion en dispositivos mejorar el contenido con espacios
    return SafeArea(
      child: Container(
        //posicion horizontal y vertical igual
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('lago con un puente', style: styleTitle),
                  SizedBox(height: 7.0),
                  Text('Un lago en Alemania', style: styleSubTitle)
                ],
              ),
            ),
            Icon(
              Icons.star,
              color: Colors.red,
              size: 30.0,
            ),
            Text('41', style: TextStyle(fontSize: 20.0))
          ],
        ),
      ),
    );
  }

  _createActions() {
    return Row(
      //distribuir proporcionalmente
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _action(Icons.call, 'CALL'),
        _action(Icons.near_me, 'ROUTE'),
        _action(Icons.near_me, 'Share')
      ],
    );
  }

  Widget _action(IconData icon, String text) {
    return Column(
      children: <Widget>[
        Icon(
          icon,
          color: Colors.blue,
          size: 40.0,
        ),
        SizedBox(height: 5.0),
        Text(text, style: TextStyle(fontSize: 15.0, color: Colors.blue))
      ],
    );
  }

  Widget _createText() {
    // al hacer rotacion en dispositivos mejorar el contenido con espacios
    return SafeArea(
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
          child: Text(
            'Irure nisi mollit consequat sunt incididunt esse ex adipisicing sunt. Mollit exercitation ex voluptate excepteur officia esse quis consectetur sint culpa tempor anim do. Id qui anim tempor pariatur mollit deserunt velit consectetur culpa ipsum sunt tempor. Elit qui cillum duis cupidatat id commodo quis. In do voluptate labore laboris est dolor veniam id nisi incididunt id. Irure aute sunt deserunt eu cupidatat commodo ut. Sint aute nisi duis do incididunt laboris.',
            textAlign: TextAlign.justify,
          )),
    );
  }
}
