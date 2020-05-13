import 'package:flutter/material.dart';
import 'package:peliculas/providers/peliculas_prividers.dart';
import 'package:peliculas/search/search_delegate.dart';
import 'package:peliculas/widgets/card_swiper_widget.dart';
import 'package:peliculas/widgets/movie_horinzontal.dart';

class HomePage extends StatelessWidget {
  final peliculasProvider = new PeliculasProvider();
  @override
  Widget build(BuildContext context) {

    peliculasProvider.getPopulares();


    return Scaffold(
      appBar: AppBar(
        title: Text('Peliculas'),
        backgroundColor: Colors.black,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate:DataSerch(),

              );
            },
          ),
        ],
      ),
    body: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _swiperTarjet(),
          _footer(context),
        ],
      ),
    )
    );
  }


  Widget _swiperTarjet() {
    
    
    return FutureBuilder(
      future: peliculasProvider.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {

        if(snapshot.hasData){
          return CardSwiper(
            peliculas: snapshot.data,
          );
        }else{
          return Container(
            height: 400.0,
            child: Center(
                child: CircularProgressIndicator()),
          );
        }

      },


    );
  }

  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
//        mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child: Text('Populares ' ,
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          SizedBox(height: 5.0),
          StreamBuilder(
            stream:  peliculasProvider.popularesStream,
            builder: ( BuildContext context,  AsyncSnapshot snapshot) {

              if(snapshot.hasData){
                return MovieHorinzontal(
                  peliculas: snapshot.data,
                  siguientePagina: peliculasProvider.getPopulares,
                );
              }else{
                return Center(child: CircularProgressIndicator());
              }

            return Container();
            },
          ),
        ],
      ),
    );
  }
}
