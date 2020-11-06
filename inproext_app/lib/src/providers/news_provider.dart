import 'dart:convert';
import 'package:inproext_app/src/models/article_model.dart';
import 'package:inproext_app/src/preferences/user_preferences.dart';
import 'package:http/http.dart' as http;

class NewsProvider {
  final String _url = 'https://inproextapp.firebaseio.com';

  final _prefs = new UserPreferences();

  Future<List<ArticleModel>> getInproextNews() async {
    print('loadNews');
    final url = '$_url/articles.json?auth=${_prefs.token}';

    final resp = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<ArticleModel> news = new List();

    if (decodedData == null) return [];
    //si hay error
    if (decodedData['error'] != null) return [];

    //conversion firebase - de mapa a un listado
    decodedData.forEach((id, article) {
      final prodTemp = ArticleModel.fromJson(article);
      if (prodTemp.isVisible != null && prodTemp.isVisible) {
        prodTemp.id = id;
        news.add(prodTemp);
      }
    });

    return news;
  }
}
