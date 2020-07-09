import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:movies/src/models/movie_model.dart';
import 'package:movies/src/models/actors_model.dart';

class MoviesProvider {
  String _apiKey = '4468fa513d8cec25384d7b636e83720c';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  //new properties
  int _popularPage = 0;

  //loading para optimizacion, no cargar todo de una vez
  bool _loading = false;

  //corriente de datos para stream
  List<Movie> _popularMovies = new List();

  //broadcast muchas lugares escuchando el stream
  final _popularMoviesStreamController =
      StreamController<List<Movie>>.broadcast();

  Function(List<Movie>) get popularMoviesSink =>
      _popularMoviesStreamController.sink.add;

  Stream<List<Movie>> get popularMoviesStream =>
      _popularMoviesStreamController.stream;

  void disposeStreams() {
    _popularMoviesStreamController?.close();
  }

  Future<List<Movie>> _processResponse(Uri url) async {
    final response = await http.get(url);
    final decodedData = json.decode(response.body);
    final movies = new Movies.fromJsonList(decodedData['results']);
    // print(movies.items[0].title);
    return movies.items;
  }

  Future<List<Movie>> getNowPlaying() async {
    final url = Uri.http(_url, '3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language});

    return _processResponse(url);
  }

  Future<List<Movie>> getPopularMovies() async {
    if (_loading) return [];

    _loading = true;

    _popularPage++;

    //print('Cargando siguienes');

    final url = Uri.http(_url, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
      'page': _popularPage.toString()
    });

    final response = await _processResponse(url);

    ///manejo de stream
    _popularMovies.addAll(response);
    popularMoviesSink(_popularMovies);
    ////termina de cargar info
    _loading = false;

    return response;
  }

  Future<List<Actor>> getCast(String idMovie) async {
    final url = Uri.https(_url, '3/movie/$idMovie/credits',
        {'api_key': _apiKey, 'language': _language});

    final response = await http.get(url);
    final decodedData = json.decode(response.body);
    final cast = new Cast.fromJsonList(decodedData['cast']);

    return cast.actors;
  }

  Future<List<Movie>> searchMovie(String query) async {
    final url = Uri.http(_url, '3/search/movie',
        {'api_key': _apiKey, 'language': _language, 'query': query});

    return _processResponse(url);
  }
}
