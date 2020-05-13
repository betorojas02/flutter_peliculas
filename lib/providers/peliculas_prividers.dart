
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:peliculas/models/actores_model.dart';
import 'package:peliculas/models/peliculas_model.dart';

class PeliculasProvider {

  String _apiKey = '74a41eb822680939f731a30615d5db05';
  String  _url  = 'api.themoviedb.org';
  String _lenguaje = 'es-ES';

  int _populates = 0;

  bool _cargando = false;

  List<Pelicula> _populares = new List();

  final _popularesStreamController = StreamController<List<Pelicula>>.broadcast();


  Function(List<Pelicula>) get popularesSink => _popularesStreamController.sink.add;

  Stream<List<Pelicula>> get popularesStream => _popularesStreamController.stream;

  void disposeStreams(){
    _popularesStreamController?.close();
  }

  Future<List<Pelicula>> _procesarRespuesta(Uri url )  async{
    final resp = await http.get(url);

    final decodeData = json.decode(resp.body);

    final peliculas = new Peliculas.fromJsonList(decodeData['results']);


    return peliculas.items;
  }


 Future<List<Pelicula>> getEnCines() async {

   final url  = Uri.https(_url, '/3/movie/now_playing', {
     'api_key' : _apiKey,
     'lenguaje' : _lenguaje
   });


   return await _procesarRespuesta(url);

  }

  Future<List<Pelicula>> getPopulares() async {

    if(_cargando) return[];

    _cargando = true;
    _populates++;
    final url  = Uri.https(_url, '/3/movie/popular', {
      'api_key'   : _apiKey,
      'lenguaje'  : _lenguaje,
      'page'      : _populates.toString()
    });


    final resp =  await _procesarRespuesta(url);

    _populares.addAll(resp);
    popularesSink(_populares);
    _cargando = false;
    return resp;
  }


  Future<List<Actor>> getCast(int peliId) async {

    final url = Uri.http(_url, '3/movie/$peliId/credits', {
      'api_key' : _apiKey,
      'lenguaje' : _lenguaje
    });
    
    
    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);

    final cast = new Cast.fromJsonList(decodeData['cast']);

    return cast.actores;

  }



  Future<List<Pelicula>> getbuscarPelicula(String query) async {

    final url  = Uri.https(_url, '/3/search/movie', {
      'api_key'   : _apiKey,
      'lenguaje'  : _lenguaje,
      'query'    : query
    });


    return await _procesarRespuesta(url);

  }


}