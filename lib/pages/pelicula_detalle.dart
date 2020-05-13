import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peliculas/models/actores_model.dart';
import 'package:peliculas/models/peliculas_model.dart';
import 'package:peliculas/providers/peliculas_prividers.dart';

class PeliculaDetallePage extends StatelessWidget {



  @override
  Widget build(BuildContext context) {

    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: CustomScrollView(
          slivers: <Widget>[
            _crearAppbar(pelicula),
            SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(
                  height: 10.0,
                ),
                _posterTitulo(context,pelicula),
                _description(pelicula),
                _description(pelicula),
                _description(pelicula),
                _description(pelicula),

                _getCasting(pelicula),

              ]) ,
            )
          ],
      ),
    );
  }
  Widget _crearAppbar(Pelicula pelicula){


    return SliverAppBar(
      expandedHeight: 250.0,
      elevation: 2.0,
      backgroundColor: Colors.black,

      floating: false,
      pinned: true,

      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
            pelicula.title,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        background: FadeInImage(
          placeholder: AssetImage(
            'assets/img/loading.gif',

          ),

          image: NetworkImage( pelicula.getBackgroudImage(),
          ),
          fit: BoxFit.cover,
        ),
      ),
    );

  }

  Widget _posterTitulo (BuildContext context,Pelicula pelicula ){

    return Container(
      child: Row(
      children: <Widget>[
        Hero(
          tag: pelicula.uniqueId,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image(
              image: NetworkImage(pelicula.getPostrImg()),
              height: 150.0,
            ),
          ),
        ),
        SizedBox(width: 20.0,),
        Flexible(
          child:Column (
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(pelicula.title , style: Theme.of(context).textTheme.title, overflow: TextOverflow.ellipsis,),
              Text(pelicula.originalTitle  ,style: Theme.of(context).textTheme.subhead, overflow: TextOverflow.ellipsis),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.star_border
                  ),
                  Text(pelicula.voteAverage.toString() , style: Theme.of(context).textTheme.subhead)
                ],
              )
            ],
          ),
        )
      ],
      ),
    );

  }

  Widget _description(Pelicula pelicula){

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Text(
        pelicula.overview,
        textAlign: TextAlign.justify,
      ),

    );

  }
  Widget _getCasting(Pelicula pelicula){

    final peliculasProvider = new PeliculasProvider();

    return FutureBuilder(
        future: peliculasProvider.getCast(pelicula.id),
        builder: (BuildContext context , AsyncSnapshot<List> snapshot){

          if(snapshot.hasData){
            return _crearActoresPageView(snapshot.data);
          }else{
              return Center(
                child: CircularProgressIndicator(),
              );
          }
        },
    );

  }


Widget  _crearActoresPageView(List<Actor> actores){

    return SizedBox(
      height: 190.0,
      child: PageView.builder(
          pageSnapping: false,
          itemCount: actores.length,
          itemBuilder: (context, i) =>  _actorTarjeta(actores[i]),
        controller: PageController(
          viewportFraction: 0.3,
          initialPage: 1,
        ),
      ),
    );

}

Widget _actorTarjeta(Actor actor){

    return Container(

      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'),
                image: NetworkImage(
                  actor.getFoto()
                ),
                height: 150.0,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              actor.name,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );

}

}
