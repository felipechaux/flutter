import 'package:flutter/material.dart';

import 'package:movies/src/providers/movies_provider.dart';
import 'package:movies/src/models/actors_model.dart';
import 'package:movies/src/models/movie_model.dart';

class DetailMovie extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        _createAppbar(movie),
        SliverList(
          //organizar
          delegate: SliverChildListDelegate([
            SizedBox(height: 10.0),
            _postTitle(context, movie),
            _movieDescription(movie),
            _createCasting(movie)
          ]),
        )
      ],
    ));
  }

  Widget _createAppbar(Movie movie) {
    return SliverAppBar(
        elevation: 2.0,
        backgroundColor: Colors.indigoAccent,
        expandedHeight: 150.0,
        floating: true,
        //mantener visible al hacer scrool
        pinned: true,
        snap: false,
        flexibleSpace: FlexibleSpaceBar(
          background: FadeInImage(
            image: NetworkImage(movie.getBackGroundImg()),
            placeholder: AssetImage('assets/img/loading.gif'),
            fadeInDuration: Duration(milliseconds: 15),
            fit: BoxFit.cover,
          ),
          centerTitle: true,
          title: Text(movie.title,
              style: TextStyle(color: Colors.white, fontSize: 16.0)),
        ));
  }

  Widget _postTitle(BuildContext context, Movie movie) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          Hero(
            tag: movie.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image(
                image: NetworkImage(movie.getPosterImg()),
                height: 150.0,
              ),
            ),
          ),
          SizedBox(width: 20.0),
          //widget que se adapta a tamaño restante
          Flexible(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                movie.title,
                style: Theme.of(context).textTheme.title,
                overflow: TextOverflow.ellipsis,
              ),
              Text(movie.originalTitle,
                  style: Theme.of(context).textTheme.subtitle,
                  overflow: TextOverflow.ellipsis),
              Row(
                children: <Widget>[
                  Icon(Icons.star_border),
                  Text(movie.voteAverage.toString(),
                      style: Theme.of(context).textTheme.subtitle,
                      overflow: TextOverflow.ellipsis)
                ],
              )
            ],
          ))
        ],
      ),
    );
  }

  Widget _movieDescription(Movie movie) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        child: Text(movie.overview, textAlign: TextAlign.justify));
  }

  Widget _createCasting(Movie movie) {
    final moviesProvider = new MoviesProvider();

    return FutureBuilder(
      future: moviesProvider.getCast(movie.id.toString()),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return _createActorsPageView(snapshot.data);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _createActorsPageView(List<Actor> actors) {
    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        //movimiento suave lista
        pageSnapping: false,
        controller: PageController(viewportFraction: 0.3, initialPage: 1),
        itemCount: actors.length,
        itemBuilder: (context, i) => _actorTarget(actors[i]),
      ),
    );
  }

  Widget _actorTarget(Actor actor) {
    return Container(
      child: Column(
        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                  image: NetworkImage(actor.getPhoto()),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  height: 150.0,
                  fit: BoxFit.fill)),
          Text(actor.name, overflow: TextOverflow.ellipsis)
        ],
      ),
    );
  }
}
