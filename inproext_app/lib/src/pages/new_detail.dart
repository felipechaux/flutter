import 'package:flutter/material.dart';
import 'package:inproext_app/src/models/article_model.dart';
import 'package:inproext_app/src/utils/constants.dart';
import 'package:inproext_app/src/utils/utils.dart';
import 'package:inproext_app/src/widgets/menu_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewDetail extends StatefulWidget {
  @override
  _NewDetailState createState() => _NewDetailState();
}

class _NewDetailState extends State<NewDetail> {
  int pageViewIndex = 1;
  @override
  Widget build(BuildContext context) {
    int _currentPage = 1;
    var _pageController = PageController(initialPage: 1);
    final ArticleModel article = ModalRoute.of(context).settings.arguments;

    var _pages = [
      WebView(
        initialUrl: Constants.urlCatalogue,
        javascriptMode: JavascriptMode.unrestricted,
      ),
      Stack(
        alignment: Alignment.center,
        children: <Widget>[
          _backgroundImage(context, article),
          _cardContent(context, article),
          _closeButton(context),
          _articleBotton(article)
        ],
      ),
      WebView(
        initialUrl: Constants.urlProjects,
        javascriptMode: JavascriptMode.unrestricted,
      ),
      WebView(
        initialUrl: Constants.urlRequest,
        javascriptMode: JavascriptMode.unrestricted,
      ),
      WebView(
        initialUrl: Constants.urlQuotation,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    ];

    return Scaffold(
        extendBodyBehindAppBar: true,
        drawer: MenuWidget(),
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          children: _pages,
          controller: _pageController,
        ),
        bottomNavigationBar: Container(
          margin: EdgeInsets.only(left: 2.0, right: 2.0),
          padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 1.0),
          decoration: BoxDecoration(
              color: Constants.colorRedInproext,
              borderRadius: BorderRadius.all(
                  Radius.circular(40.0) //         <--- border radius here
                  )),
          child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              showUnselectedLabels: true,
              fixedColor: Colors.white,
              unselectedFontSize: 14,
              elevation: 0,
              backgroundColor: Constants.colorRedInproext,
              unselectedItemColor: Colors.white,
              onTap: (index) {
                setState(() {
                  _currentPage = index;
                  _pageController.animateToPage(_currentPage,
                      duration: Duration(milliseconds: 250),
                      curve: Curves.easeInOut);
                  pageViewIndex = index;
                });
              },
              currentIndex: _currentPage,
              items: [
                BottomNavigationBarItem(
                    icon: Image(
                        width: 22,
                        image:
                            AssetImage('assets/images/ico_bnb_catalogue.png')),
                    title: Container(
                      padding: EdgeInsets.only(top: 3.0),
                      child: Text('Catálogo',
                          style: TextStyle(
                              fontFamily: Constants.fontTitilliumWebLight)),
                    )),
                BottomNavigationBarItem(
                    icon: Image(
                        width: 25,
                        image: AssetImage('assets/images/ico_bnb_news.png')),
                    title: Container(
                      padding: EdgeInsets.only(top: 6.0),
                      child: Text('Artículos',
                          style: TextStyle(
                              fontFamily: Constants.fontTitilliumWebLight)),
                    )),
                BottomNavigationBarItem(
                    icon: Image(
                      width: 25,
                      image: AssetImage('assets/images/ico_bnb_proyects.png'),
                    ),
                    title: Container(
                      padding: EdgeInsets.only(top: 4.0),
                      child: Text('Proyectos',
                          style: TextStyle(
                              fontFamily: Constants.fontTitilliumWebLight)),
                    )),
                BottomNavigationBarItem(
                    icon: Image(
                      width: 35,
                      image: AssetImage('assets/images/ico_bnb_req.png'),
                    ),
                    title: Container(
                      padding: EdgeInsets.only(top: 4.0),
                      child: Text('Petición',
                          style: TextStyle(
                              fontFamily: Constants.fontTitilliumWebLight)),
                    )),
                BottomNavigationBarItem(
                    icon: Padding(
                      padding: EdgeInsets.only(top: 7.0),
                      child: Image(
                          width: 30,
                          image: AssetImage(
                              'assets/images/ico_bnb_quotation.png')),
                    ),
                    title: Container(
                      padding: EdgeInsets.only(top: 2.0),
                      child: Text('Cotización',
                          style: TextStyle(
                              fontFamily: Constants.fontTitilliumWebLight)),
                    )),
              ]),
        ),
        appBar: (pageViewIndex == 1)
            ? AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                titleSpacing: 5,
                title: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Artículos',
                        style: TextStyle(
                            fontFamily: Constants.fontPoppinnsLight,
                            fontSize: 16.0))),
                leading: Builder(builder: (BuildContext context) {
                  return IconButton(
                    icon: Image.asset(
                      'assets/images/ico_menu.png',
                      height: 18.0,
                    ),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  );
                }))
            : null);
  }

  Widget _backgroundImage(BuildContext context, ArticleModel article) {
    //final _screenSize = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(bottom: 70.0),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: FadeInImage(
          placeholder: AssetImage('assets/images/loader.gif'),
          image: NetworkImage(article.urlImage),
          //ocupar todo el espacio disponible
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _cardContent(BuildContext context, ArticleModel article) {
    final _screenSize = MediaQuery.of(context).size;

    return Align(
        alignment: Alignment.bottomCenter,
        child: OrientationBuilder(builder: (_, orientation) {
          if (orientation == Orientation.portrait)
            return Container(
              padding: EdgeInsets.only(bottom: 40.0),
              height: _screenSize.height * 0.60,
              child: Card(
                color: Constants.colorBlueInproext,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 30.0),
                      _titleContent(article),
                      SizedBox(height: 28.0),
                      Text(
                        article.content,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontFamily: Constants.fontTitilliumWebLight,
                            color: Colors.white),
                      ),
                      SizedBox(height: 23.0),
                    ],
                  ),
                ),
              ),
            );
          else
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(bottom: 40.0),
                height: _screenSize.height * 0.90,
                child: Card(
                  color: Constants.colorBlueInproext,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 30.0),
                        _titleContent(article),
                        SizedBox(height: 28.0),
                        Text(
                          article.content,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              fontFamily: Constants.fontTitilliumWebLight,
                              color: Colors.white),
                        ),
                        SizedBox(height: 23.0),
                      ],
                    ),
                  ),
                ),
              ),
            );
        }));
  }

  Widget _titleContent(ArticleModel article) {
    return Align(
        alignment: Alignment.centerLeft,
        child: Text(
          article.title,
          style: TextStyle(
              color: Colors.white,
              fontSize: 30.0,
              fontFamily: Constants.fontTitilliumWebSemiBold),
        ));
  }

  Widget _articleBotton(ArticleModel article) {
    return Positioned(
      bottom: 80,
      left: 50,
      width: 120.0,
      height: 45.0,
      child: FlatButton(
        color: Colors.white,
        onPressed: () {
          print('ir al articulo ${article.urlArticle}');
          launchUrl(article.urlArticle);
        },
        child: Text(
          'Ir al artículo',
          style: TextStyle(
              fontFamily: Constants.fontTitilliumWebLight, color: Colors.black),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
      ),
    );
  }

  Widget _closeButton(BuildContext context) {
    return Positioned(
      bottom: 80.0,
      width: 120.0,
      right: 50.0,
      height: 45.0,
      child: FlatButton(
        color: Constants.colorRedInproext,
        onPressed: () {
          Navigator.pushNamed(context, 'news');
        },
        child: Text(
          'Cerrar',
          style: TextStyle(
              fontFamily: Constants.fontTitilliumWebLight, color: Colors.white),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
      ),
    );
  }
}
