import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:peliculasapp/models/movie.dart';

class CardSwiper extends StatelessWidget {

  final List<Movie> movies;

  const CardSwiper({
    Key? key,
    required this.movies
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    /*
    MediaQuery.of( context ).size nos sirve para pode obtener el tamaño de nuestra pantalla y de esta manera
    se puede adaptar a las demas pantallas de manera dinamica evitando asi el descargar plugins externos.
    */

    final size = MediaQuery.of( context ).size; 

    if( this.movies.length == 0 ) {
      return Container(
        width: double.infinity,
        height: size.height * 0.5,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Container(

      width: double.infinity, // Lo que hace es tomar todo el ancho de la pantalla del celular.
      height: size.height * 0.9, // Toma el 50% de la pantalla de nuestro movil aumentar o disminuir dependiendo de lo requerido  
      child: Swiper(
        itemCount: movies.length,
        viewportFraction: 0.8,
        scale: 0.9,
        // layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.7,
        itemHeight: size.height * 0.7,
        itemBuilder: ( _ , int index ) {
          
          // Ruta de las imagenes:
          final movie = movies[index];
          // Esta propiedad (widget) nos retorna una animación:

          movie.heroId = 'swiper-${ movie.id }';

          return GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details', arguments: movie),
            child: Hero(
              tag: movie.heroId!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: AssetImage('assets/no-image.jpg'), //NetworkImage('https://via.placeholder.com/300x350'),
                  image: NetworkImage(movie.fullPosterImg),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );

        },
      ),    
    );
  }
}