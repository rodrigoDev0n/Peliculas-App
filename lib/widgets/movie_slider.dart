
import 'package:flutter/material.dart';
import 'package:peliculasapp/models/models.dart';
import 'package:peliculasapp/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class MovieSlider extends StatefulWidget {

  final List<Movie> movies;
  final String? title;
  final Function onNextPage;

  const MovieSlider({
    Key? key,
    required this.movies,
    required this.onNextPage,
    this.title
  }) : super(key: key);

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {

  final ScrollController scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() { 

      if( scrollController.position.pixels >= scrollController.position.maxScrollExtent - 500 ){
        widget.onNextPage();
      }

    });

  }

  @override
  Widget build(BuildContext context) {

    final myThemeProvider = Provider.of<MoviesProvider>(context);

    return Container(
      width: double.infinity,
      height: 280.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          if( widget.title != null ) 
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                widget.title.toString(),
                style: TextStyle(
                  fontSize: 20.0, 
                  fontWeight: FontWeight.bold,
                  color: myThemeProvider.getTextColor()
                ),
              ),
            ),

          SizedBox( height: 5.0, ),

          Expanded(
            child: ListView.builder(  
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.movies.length,
              itemBuilder: ( _ , int index ) => _MoviePoster( widget.movies[index], '${ widget.title }-$index-${ widget.movies[index].id }'),
            ),
            
          )

        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {

  final Movie movie;
  final String heroId;

  const _MoviePoster( this.movie, this.heroId );

  @override
  Widget build(BuildContext context) {

    movie.heroId = heroId;
    final myThemeProvider = Provider.of<MoviesProvider>(context);

    return Container(
      width: 130,
      height: 190,
      margin: EdgeInsets.symmetric( horizontal: 10 ),
      child: Column(
        children: [

          GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details', arguments: movie ),
            child: Hero(
              tag: movie.heroId!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: AssetImage('assets/no-image.jpg'), 
                  image: NetworkImage( movie.fullPosterImg ),
                  width: 130,
                  height: 190,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          SizedBox( height: 5.0, ),

          Text(
            '${movie.title}',
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.center,
  
            style: TextStyle(
              color: myThemeProvider.getTextColor()
            ),

          ),

        ],
      ),
    );
  }
}

/*
  Aclaración importante: 
  overflow: TextOverflow.ellipsis permite que a los textos muy largos que sean mas grandes que el tamaño
  de su contenedor se les agreguen 3 puntos suspensivos para que de esta manera no debamos manejar los
  tamaños de nuestros contenedores de mala manera.

  Nos ayuda a renderizar de buena manera los textos de nuestra aplicación.

  ClipRRect() este widget nos permite especificar el borderradius que queremos que tengan nuestros
  elementos.
*/