import 'package:flutter/material.dart';
import 'package:inproext_app/src/utils/constants.dart';
import 'package:inproext_app/src/widgets/list_news_widget.dart';
import 'package:inproext_app/src/widgets/menu_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  int pageViewIndex = 1;

  @override
  Widget build(BuildContext context) {
    int _currentPage = 1;

    var _pageController = PageController(initialPage: 1);

    var _pages = [
      WebView(
        initialUrl: Constants.urlCatalogue,
        javascriptMode: JavascriptMode.unrestricted,
      ),
      Stack(
        children: <Widget>[
          _backgroundNews(context),
          Container(
            padding: EdgeInsets.only(top: 60.0),
            alignment: Alignment.topCenter,
            child: Column(
              children: <Widget>[
                Text('Explora los',
                    textAlign: TextAlign.justify,
                    style: (TextStyle(
                        fontFamily: Constants.fontPoppinnsMedium,
                        fontSize: 22,
                        color: Constants.colorWhite))),
                Text('diferentes artículos',
                    textAlign: TextAlign.justify,
                    style: (TextStyle(
                        fontFamily: Constants.fontPoppinnsMedium,
                        fontSize: 22,
                        color: Constants.colorWhite)))
              ],
            ),
          ),
          ListNewsWidget()
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
        extendBodyBehindAppBar: true,
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
                    //tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                  );
                }))
            : null);
  }

  Widget _backgroundNews(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Image(
        //ocupar todo el espacio disponible
        fit: BoxFit.cover,
        image: AssetImage('assets/images/img_new.jpg'),
      ),
    );
  }
}
