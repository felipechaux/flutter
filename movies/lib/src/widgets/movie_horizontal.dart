import 'package:flutter/material.dart';
import 'package:movies/src/models/movie_model.dart';

//stateless encargado de reutilizar
class MovieHorizontal extends StatelessWidget {
  final List<Movie> movies;

  //propiedad para callback padre
  final Function nextPage;

  MovieHorizontal({@required this.movies, @required this.nextPage});

  //controlador
  final _pageController =
      new PageController(initialPage: 1, viewportFraction: 0.3);

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    //disparar cada vez que se mueva el scroll
    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        nextPage();
      }
    });

    return Container(
        //2%
        height: _screenSize.height * 0.25,
        //builer mejora de rendimiento por ser tanta info
        child: PageView.builder(
            //efecto iman
            pageSnapping: false,
            controller: _pageController,
            // children: _targets(context)),
            itemCount: movies.length,
            itemBuilder: (context, i) => _target(context, movies[i])));
  }

  //mejora de targets
  Widget _target(BuildContext context, Movie movie) {
    movie.uniqueId = '${movie.id}-poster';

    final movieTarget = Container(
      margin: EdgeInsets.only(right: 5.0),
      child: Column(
        children: <Widget>[
          //hero effect
          Hero(
            tag: movie.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage(movie.getPosterImg()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.cover,
                height: 150.0,
              ),
            ),
          ),
          SizedBox(height: 5.0),
          Text(
            movie.title,
            //.. cuando no cabe el contenido
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          )
        ],
      ),
    );

    return GestureDetector(
      child: movieTarget,
      onTap: () {
        Navigator.pushNamed(context, 'detail', arguments: movie);
        print('ID de la pelicula ${movie.id}');
      },
    );
  }

  /*List<Widget> _targets(BuildContext context) {
    return movies.map((movie) {
      return Container(
        margin: EdgeInsets.only(right: 5.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage(movie.getPosterImg()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.cover,
                height: 150.0,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              movie.title,
              //.. cuando no cabe el contenido
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            )
          ],
        ),
      );
    }).toList();
  }*/
}
