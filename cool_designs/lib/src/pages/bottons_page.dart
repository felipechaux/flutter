import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:math';

class BottonsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: <Widget>[
            _backGround(),
            SingleChildScrollView(
              child: Column(
                children: <Widget>[_titles(), _circleBottoms()],
              ),
            )
          ],
        ),
        bottomNavigationBar: _bottomNavigationBar(context)
        /* botones normales 
      BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), title: Container()),
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart_outlined),
            title: Container(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.supervised_user_circle),
            title: Container(),
          )
        ],
      )*/
        );
  }

  Widget _backGround() {
    final gradient = Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            //gradiente paralelo
            gradient: LinearGradient(
                //0.0 inicio de gradiente, 6.0 -> 60 % de pantalla
                begin: FractionalOffset(0.0, 0.6),
                end: FractionalOffset(0.0, 1.0),
                colors: [
              Color.fromRGBO(52, 54, 101, 1.0),
              Color.fromRGBO(35, 37, 57, 1.0)
            ])));

    final boxPink = Transform.rotate(
        angle: -pi / 4.0,
        child: Container(
            height: 360.0,
            width: 360.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(80.0),
                gradient: LinearGradient(colors: [
                  Color.fromRGBO(236, 98, 188, 1.0),
                  Color.fromRGBO(241, 142, 172, 1.0)
                ]))));

    return Stack(
      children: <Widget>[
        gradient,
        //ubicar elemento en coordenadas
        Positioned(
          child: boxPink,
          top: -100.0,
        )
      ],
    );
  }

  Widget _titles() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Classify transaction',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text('Classify this transaction into a particular category',
                style: TextStyle(color: Colors.white, fontSize: 18.0))
          ],
        ),
      ),
    );
  }

  //personalizacion de bottomNavigationBar
  Widget _bottomNavigationBar(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          //fondo
          canvasColor: Color.fromRGBO(55, 57, 84, 1.0),
          //color primario
          primaryColor: Colors.pinkAccent,
          //color secundario
          textTheme: Theme.of(context).textTheme.copyWith(
              caption: TextStyle(color: Color.fromRGBO(116, 117, 152, 1.0)))),
      child: BottomNavigationBar(items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today, size: 30.0), title: Container()),
        BottomNavigationBarItem(
          icon: Icon(Icons.pie_chart_outlined, size: 30.0),
          title: Container(),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.supervised_user_circle, size: 30.0),
          title: Container(),
        )
      ]),
    );
  }

  Widget _circleBottoms() {
    return Table(
      children: [
        TableRow(children: [
          _createCircleButtom(Colors.blue, Icons.border_all, 'General'),
          _createCircleButtom(
              Colors.purpleAccent, Icons.directions_bus, 'Found me')
        ]),
        TableRow(children: [
          _createCircleButtom(
              Colors.yellow, Icons.confirmation_number, 'Configuration'),
          _createCircleButtom(Colors.red, Icons.border_all, 'Enroll')
        ]),
        TableRow(children: [
          _createCircleButtom(Colors.grey, Icons.keyboard_hide, 'Setup'),
          _createCircleButtom(Colors.lime, Icons.cloud, 'Organized')
        ]),
        TableRow(children: [
          _createCircleButtom(Colors.black, Icons.link_off, 'Tile'),
          _createCircleButtom(Colors.cyan, Icons.games, 'Play')
        ])
      ],
    );
  }

  Widget _createCircleButtom(Color color, IconData icon, String text) {
    //correccion error en dispositivos
    return ClipRect(
      //BackdropFilter->efecto borroso
      child: BackdropFilter(
        //blue consume recursos considetables ****
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          height: 180.0,
          //separacion entre todos los elementos
          margin: EdgeInsets.all(15.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Color.fromRGBO(62, 66, 107, 0.7)),
          child: Column(
            //acomodar elementos
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              SizedBox(height: 5.0),
              CircleAvatar(
                //crecer
                radius: 35.0,
                backgroundColor: color,
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 30.0,
                ),
              ),
              Text(
                text,
                style: TextStyle(color: color),
              ),
              SizedBox(height: 5.0)
            ],
          ),
        ),
      ),
    );
  }
}
