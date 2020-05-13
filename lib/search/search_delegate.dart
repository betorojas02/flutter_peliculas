import 'package:flutter/material.dart';
import 'package:peliculas/models/peliculas_model.dart';
import 'package:peliculas/providers/peliculas_prividers.dart';


class DataSerch extends SearchDelegate {

  final peliculasProvider = new PeliculasProvider();

  final peliculas = [
    'halo',
    'aguaman',
    'BATAMN',
    'SHAMZAM',
    'IROMAN',
    'capitan america',


  ];

  final peliculasReciente  = [
    'Sppiderman',
    'capitan america',

  ];
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: acciones de nuevo appbar


    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
        query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a al izquierda del appbar
    return
      IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        },
      );


  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: build o instruccion que crea los resultados a mostrar
    return Container();

  }

  @override
  Widget buildSuggestions(BuildContext context) {

    if(query.isEmpty) {
      return Container();
    }

    return FutureBuilder(
        future: peliculasProvider.getbuscarPelicula(query) ,
        builder: (context, AsyncSnapshot<List<Pelicula>> snapshot) {
            if(snapshot.hasData){
              final peliculas = snapshot.data;
              return ListView(
                  children: peliculas.map((e) {
                      return ListTile(
                        leading: FadeInImage(
                          image: NetworkImage(e.getPostrImg()),
                          placeholder: AssetImage('assets/img/no-image.jpg'),
                          // ignore: missing_return
                          width: 50.0,
                          fit: BoxFit.cover,
                        ),
                        title: Text(e.title),
                        subtitle: Text(e.originalTitle),
                        onTap: (){
                          close(context, null);
                          e.uniqueId = '';
                          Navigator.pushNamed(context, 'detalle' , arguments: e);
                        },
                      );
                  }).toList()
              );
            }else{

              return Center(
                child: CircularProgressIndicator(),
              );

            }

        },

        );






    // TODO: sugerencias cuando la persona escribe

/*    final listaSugerida = (query.isEmpty) ? peliculasReciente : peliculas.where((element) => element.toLowerCase().startsWith(query.toLowerCase())).toList();


    return ListView.builder(
        itemCount: listaSugerida.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.movie),
            title: Text(listaSugerida[index]) ,
            onTap: () {

            },
          );
        },
    );*/
  }

  
}