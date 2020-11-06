import 'package:flutter/material.dart';
import 'package:inproext_app/src/bloc/provider.dart';
import 'package:inproext_app/src/models/article_model.dart';
import 'package:inproext_app/src/utils/constants.dart';

class ListNewsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    final inproextNews = Provider.articlesBloc(context);
    inproextNews.loadInproextNews();

    return StreamBuilder(
      stream: inproextNews.articlesStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          final articles = snapshot.data;
          return ListView.builder(
              padding: EdgeInsets.only(top: _screenSize.height * 0.22),
              itemCount: articles.length,
              itemBuilder: (context, i) => Container(
                    padding: EdgeInsets.only(left: 15.0, right: 5.0),
                    child: _article(context, articles[i]),
                  ));
        } else {
          return Center(
              child: Container(
                  margin: EdgeInsets.only(right: 16.0, top: 12.0),
                  child: Image(
                      width: 150,
                      height: 150,
                      image: AssetImage('assets/images/loader.gif'))));
        }
      },
    );
  }

  Widget _article(BuildContext context, ArticleModel article) {
    final _screenSize = MediaQuery.of(context).size;
    //155
    return Stack(
      children: <Widget>[
        Card(
            elevation: 3.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    topLeft: Radius.circular(8.0))),
            child: Container(
              height: _screenSize.height * 0.21,
            )),
        Row(
          children: <Widget>[
            Container(
              width: 260.0,
              padding: EdgeInsets.only(left: 25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 53,
                  ),
                  _titleArticle(article),
                  _content(context, article),
                ],
              ),
            ),
            Expanded(child: _imageArticle(article))
          ],
        ),
      ],
    );
  }

  Widget _imageArticle(ArticleModel articleModel) {
    return Container(
        margin: EdgeInsets.only(right: 16.0, top: 12.0),
        child: (articleModel.urlImage != null)
            ? FadeInImage(
                placeholder: AssetImage('assets/images/loader.gif'),
                image: NetworkImage(articleModel.urlImage))
            : Image(
                image: AssetImage('assets/no-image.png'),
              ));
  }

  Widget _titleArticle(ArticleModel article) {
    return Container(
      margin: EdgeInsets.only(right: 4.0),
      child: Align(
          alignment: Alignment.centerLeft,
          child: Text(article.title,
              style: TextStyle(
                  fontFamily: Constants.fontSignikaLight,
                  color: Constants.colorBlueInproext,
                  fontSize: 18.0))),
    );
  }

  Widget _content(BuildContext context, ArticleModel article) {
    return Column(
      children: <Widget>[
        Text(
          article.description,
          style: TextStyle(
              fontFamily: Constants.fontTitilliumWebLight, color: Colors.black),
        ),
        SizedBox(height: 10.0),
        Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, 'detail', arguments: article);
              },
              child: Row(
                children: <Widget>[
                  Image(
                      width: 15.0,
                      image: AssetImage('assets/images/ico_show_more.png')),
                  SizedBox(width: 7.0),
                  Text('Ver más',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: Constants.fontTitilliumWebLight,
                          fontSize: 12.0)),
                ],
              ),
            ))
      ],
    );
  }
}
