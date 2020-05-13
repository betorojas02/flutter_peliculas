import 'package:flutter/material.dart';
import 'package:peliculas/pages/home_page.dart';
import 'package:peliculas/pages/pelicula_detalle.dart';

Map<String, WidgetBuilder> getAplicationRoutes() {
  return <String, WidgetBuilder>{
    '/'         : (BuildContext context) => HomePage(),
    'detalle'         : (BuildContext context) => PeliculaDetallePage(),

  };
}