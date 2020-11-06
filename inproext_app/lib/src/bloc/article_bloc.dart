import 'package:inproext_app/src/models/article_model.dart';
import 'package:inproext_app/src/providers/news_provider.dart';
import 'package:rxdart/rxdart.dart';

class ArticleBLoc {
  final _articlesProvider = new NewsProvider();

  final _articlesController = new BehaviorSubject<List<ArticleModel>>();

  Stream<List<ArticleModel>> get articlesStream => _articlesController.stream;

  void loadInproextNews() async {
    final products = await _articlesProvider.getInproextNews();
    _articlesController.sink.add(products);
  }

  dispose() {
    _articlesController?.close();
  }
}
