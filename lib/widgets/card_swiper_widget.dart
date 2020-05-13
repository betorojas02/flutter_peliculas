import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas/models/peliculas_model.dart';
class CardSwiper extends StatelessWidget {

  final List<Pelicula> peliculas;

  CardSwiper({ @required this.peliculas}){

  }
  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemHeight:_screenSize.height*0.5,
        itemWidth: _screenSize.width * 0.7,
        itemBuilder: (BuildContext context,int index){

          peliculas[index].uniqueId = '${peliculas[index].id}-tarjeta';
          return Hero(
            tag: peliculas[index].uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: GestureDetector(
                child: FadeInImage(
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  image: NetworkImage(peliculas[index].getPostrImg()),
                  fit: BoxFit.cover,
                ),
                onTap: () {
                  Navigator.pushNamed(
                      context, 'detalle', arguments: peliculas[index]);
                }
              ),
                //se adapta  las imagenes a las dimenciones que tiene su contenedor
            ),
          );
        },
        itemCount: peliculas.length,
//        pagination: new SwiperPagination(),
//        control: new SwiperControl(),
      ),
    );
  }
}
