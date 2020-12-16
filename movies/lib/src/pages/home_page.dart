import 'package:flutter/material.dart';
import 'package:movies/src/providers/movies_provider.dart';
import 'package:movies/src/widgets/card_swiper_widget.dart';
import 'package:movies/src/widgets/movie_horizontal.dart';
import 'package:movies/src/search/search_delegate.dart';

class HomePage extends StatelessWidget {
  final moviesProvider = new MoviesProvider();

  @override
  Widget build(BuildContext context) {
    ////llamada a metodo con coleccion de peliculas populares
    moviesProvider.getPopularMovies();

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Movies in cinema'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: DataSearch(),
                  // query: 'Hola k hace'
                );
              })
        ],
      ),
      //ajustar bajo el area barra
      //body: SafeArea(child: Text('Hola mubdo')
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          child: Column(
            //espacio entre elementos
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[_swiperTargets(), _footer(context)],
          ),
        ),
      ),
    );
  }

  Widget _swiperTargets() {
    return FutureBuilder(
      future: moviesProvider.getNowPlaying(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(movies: snapshot.data);
        } else {
          return Container(
              height: 400.0, child: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }

  Widget _footer(BuildContext context) {
    return Container(
      //todo el espacio
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(left: 20.0),
              child: Text('Popular movies',
                  style: Theme.of(context).textTheme.title)),
          SizedBox(height: 5.0),
          //implementacion stream
          StreamBuilder(
              stream: moviesProvider.popularMoviesStream,
              builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                //recorrer objeto
                //snapshot.data?.forEach((p) => print(p.title));
                if (snapshot.hasData) {
                  return MovieHorizontal(
                      movies: snapshot.data,
                      // nextPage solo se llama a la definicion
                      nextPage: moviesProvider.getPopularMovies);
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              })
        ],
      ),
    );
  }
}
