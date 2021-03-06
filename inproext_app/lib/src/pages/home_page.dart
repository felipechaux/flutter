import 'package:flutter/material.dart';
import 'package:inproext_app/src/utils/constants.dart';
import 'package:inproext_app/src/utils/utils.dart';
import 'package:inproext_app/src/widgets/menu_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MenuWidget(),
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: Builder(builder: (BuildContext context) {
              return IconButton(
                icon: Image.asset(
                  'assets/images/ico_menu.png',
                  height: 18.0,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                //tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            })),
        body: Stack(
          children: <Widget>[
            _backgroundHome(context),
            SingleChildScrollView(child: _content(context))
          ],
        ));
  }

  Widget _backgroundHome(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Image(
        //ocupar todo el espacio disponible
        fit: BoxFit.cover,
        image: AssetImage('assets/images/img_home.jpg'),
      ),
    );
  }

  Widget _content(BuildContext context) {
    return Center(
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 120.0),
          _proyectsCard(),
          SizedBox(height: 30.0),
          _requestCard(),
          SizedBox(height: 30.0),
          _catalogueCard(),
          SizedBox(height: 30.0),
          _quotationCard(),
          SizedBox(height: 30.0),
          _newsCard(context),
          SizedBox(height: 30.0),
        ],
      ),
    );
  }
}

Widget _proyectsCard() {
  return Stack(
    children: <Widget>[
      GestureDetector(
        onTap: () => launchUrl(Constants.urlProjects),
        child: Card(
            elevation: 3.0,
            margin: EdgeInsets.only(left: 35.0),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Container(
              alignment: Alignment.center,
              width: 300,
              height: 100,
              child: Text('Mis Proyectos',
                  style: TextStyle(
                      fontFamily: Constants.fontPoppinnsMedium,
                      fontSize: 20.0)),
            )),
      ),
      Card(
          elevation: 3.0,
          margin: EdgeInsets.only(left: 2.0, top: 20.0),
          child: Container(
            height: 60.0,
            width: 60.0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image(
                image: AssetImage('assets/images/ico_projects.png'),
                height: 12,
                width: 12,
              ),
            ),
          )),
    ],
  );
}

Widget _newsCard(BuildContext context) {
  return Stack(
    children: <Widget>[
      GestureDetector(
        onTap: () => Navigator.pushNamed(context, 'news'),
        child: Card(
            margin: EdgeInsets.only(left: 35.0),
            elevation: 3.0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Container(
              alignment: Alignment.center,
              width: 300,
              height: 100,
              child: Text('Artículos',
                  style: TextStyle(
                      fontFamily: Constants.fontPoppinnsMedium,
                      fontSize: 20.0)),
            )),
      ),
      Card(
          elevation: 3.0,
          margin: EdgeInsets.only(left: 2.0, top: 20.0),
          child: Container(
            height: 60.0,
            width: 60.0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image(
                image: AssetImage('assets/images/ico_news.png'),
                height: 12,
                width: 12,
              ),
            ),
          )),
    ],
  );
}

Widget _requestCard() {
  return Stack(
    children: <Widget>[
      GestureDetector(
        onTap: () => launchUrl(Constants.urlRequest),
        child: Card(
            margin: EdgeInsets.only(left: 35.0),
            elevation: 3.0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Container(
              alignment: Alignment.center,
              width: 300,
              height: 100,
              child: Text('Petición',
                  style: TextStyle(
                      fontFamily: Constants.fontPoppinnsMedium,
                      fontSize: 20.0)),
            )),
      ),
      Card(
          elevation: 3.0,
          margin: EdgeInsets.only(left: 2.0, top: 20.0),
          child: Container(
            height: 60.0,
            width: 60.0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image(
                image: AssetImage('assets/images/ico_request.png'),
                height: 12,
                width: 12,
              ),
            ),
          )),
    ],
  );
}

Widget _catalogueCard() {
  return Stack(
    children: <Widget>[
      GestureDetector(
        onTap: () => launchUrl(Constants.urlCatalogue),
        child: Card(
            margin: EdgeInsets.only(left: 35.0),
            elevation: 3.0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Container(
              alignment: Alignment.center,
              width: 300,
              height: 100,
              child: Text('Catálogo',
                  style: TextStyle(
                      fontFamily: Constants.fontPoppinnsMedium,
                      fontSize: 20.0)),
            )),
      ),
      Card(
          elevation: 3.0,
          margin: EdgeInsets.only(left: 2.0, top: 20.0),
          child: Container(
            height: 60.0,
            width: 60.0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image(
                image: AssetImage('assets/images/ico_catalogue.png'),
                height: 12,
                width: 12,
              ),
            ),
          )),
    ],
  );
}

Widget _quotationCard() {
  return Stack(
    children: <Widget>[
      GestureDetector(
        onTap: () => launchUrl(Constants.urlQuotation),
        child: Card(
            margin: EdgeInsets.only(left: 35.0),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 3.0,
            child: Container(
              alignment: Alignment.center,
              width: 300,
              height: 100,
              child: Text('Cotización',
                  style: TextStyle(
                      fontFamily: Constants.fontPoppinnsMedium,
                      fontSize: 20.0)),
            )),
      ),
      Card(
          elevation: 3.0,
          margin: EdgeInsets.only(left: 2.0, top: 20.0),
          child: Container(
            height: 60.0,
            width: 60.0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image(
                image: AssetImage('assets/images/ico_quotation.png'),
                height: 12,
                width: 12,
              ),
            ),
          )),
    ],
  );
}
