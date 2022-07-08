
import 'package:flutter/material.dart';
import 'package:peliculasapp/models/models.dart';
import 'package:peliculasapp/providers/movies_provider.dart';
import 'package:peliculasapp/widgets/widgets.dart';
import 'package:provider/provider.dart';

class DetailsScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

  // TODO: Cambiar luego por una instancia de movie.
    final Movie movie = ModalRoute.of( context )!.settings.arguments as Movie;
  /*
    La variable movie que hemos definido en la parte superior nos sirve para poder leer cuales son 
    los argumentos que trae nuestra pelicula ya que al seleccionar una de las peliculas vamos a 
    enviar los argumentos de esta misma los signos de interrogación nos sirve para indicar y 
    a modo de consulta si es que viene o no un argumento en este caso si nuestra pelicula seleccionada
    no tiene argumentos nos debera mostrar el texto no-movie y en caso contrario osea si es que nuestra
    pelicula selecciionada tiene algun argumento nos mostrara movie-instance.
  */ 

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppbar( movie ),
          SliverList(
            delegate: SliverChildListDelegate([
              _PosterAndTitle( movie ),
              _OverView( movie ),
              CastingCard( movie.id )
            ]) 
          )
        ],
      ),
    );
  }
}

/*
  CustoScrollView(): al igual que SingleScrollView() nos sirve para poder manejar demasiada información
  dentro de nuestra pantalla y podamos hacer scroll pero esta hecho especificamente para poder trabajar
  con slivers: []

  ¿Que son los slivers: []?

  Los slivers no son mas que widgets que tienen comportamiento preprogamado cuando hacemos scroll
  en el widget del padre o en el widget padre.

  SliverList(): Este widget nos sirve para poder utilizar nuestros widgets normales como text, container,
  column, etc dentro de nuestros slivers ya que si utilizamos uno de estos widgets normales dentro de nuestro
  slivers nos dara un error.
*/

class _CustomAppbar extends StatelessWidget {

  final Movie movie;

  _CustomAppbar( this.movie );

  @override
  Widget build(BuildContext context) {

    final myThemesProvider = Provider.of<MoviesProvider>(context);

    return SliverAppBar(
      backgroundColor: Colors.indigo.shade900,
      expandedHeight: 200,
      floating: true,
      pinned: true,
      snap: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.all(0),
        title: Container(
          padding: EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
          color: Colors.black12,
          alignment: Alignment.bottomCenter,
          width: double.infinity, // obtiene todo el ancho de la pantalla del dispositivo
          child: Text(
            '${movie.title}',
            style: TextStyle( color: Colors.white ),
            textAlign: TextAlign.center,
          ),
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/loading.gif'), 
          image: NetworkImage('${movie.fullBackdropPath}'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {

  final Movie movie;

  _PosterAndTitle(this.movie);

  @override
  Widget build(BuildContext context) {

    final TextTheme textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size; 
    // Obtiene las dimensiones de la pantalla del dispositivo.

    final myThemeProvider = Provider.of<MoviesProvider>(context);
    
    /*var colores;
    myThemeProvider.themeMode == ThemeMode.dark 
    ? colores = Colors.white 
    : colores = Colors.black;*/

    return Container(
      margin: EdgeInsets.only( top: 20.0 ),
      padding: EdgeInsets.symmetric( horizontal: 20.0 ),
      child: Row(
        children: [
          Hero(
            tag: movie.heroId!,
            child: ClipRRect( 
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/no-image.jpg'), 
                image: NetworkImage('${movie.fullPosterImg}'),
                height: 150.0,
              ),
            ),
          ),

          SizedBox( width: 20.0, ), // permite separar contenedores o widgets

          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: size.width - 190),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${movie.title}',
                  style: TextStyle( color: myThemeProvider.getTextColor() ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),

                Text(
                  '${movie.originalTitle}',
                  style: TextStyle( color: myThemeProvider.getTextColor() ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
          
                Row(
                  children: [
                    Icon( Icons.star_outline, size: 15.0, color: Colors.yellow, ),
                    SizedBox(width: 5.0,),
                    Text(
                      '${movie.voteAverage}',
                      style: TextStyle( color: myThemeProvider.getTextColor() ),
                    )
                  ],
                ),
              ],
            ),
          )

        ],
      ),
    );
  }
}

/*
  SizedBox(): Este widget nos va a servir para poder crear separaciones entre los diferentes contenidos de 
  nuestra aplicación.
*/

// TODO: Investigar mas sobre theme eb flutter como aplicarlo dentro de nuestras aplicaciones.

class _OverView extends StatelessWidget {

  final Movie movie;
  _OverView(this.movie);

  @override
  Widget build(BuildContext context) { 

    final myThemeProvider = Provider.of<MoviesProvider>(context);

    final noDataContainer = Container(
      child: Column(
        children: [

          SizedBox(height: 50.0,),

          Center(
            child: FadeInImage(
              placeholder: AssetImage('assets/no-info.png'), 
              image: AssetImage('assets/no-info.png'),
              height: 100.0, 
            )
          ),

          Center(
            child: Text(
              'No existe información disponible para esta pelicula',
              style: TextStyle( color: myThemeProvider.getTextColor() ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),

          SizedBox(height: 50.0,)

        ],
      ),
    );

    if( movie.overview == '' ) return noDataContainer;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
      child: Text(
        movie.overview,
        textAlign: TextAlign.justify,
        style: TextStyle( color: myThemeProvider.getTextColor() ),
      ),
    );
  }
}


// El widget hero nos permite crear una transición mas agradable a la vista
// 