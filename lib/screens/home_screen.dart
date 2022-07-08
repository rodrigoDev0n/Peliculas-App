import 'package:flutter/material.dart';
import 'package:peliculasapp/providers/movies_provider.dart';
import 'package:peliculasapp/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'package:peliculasapp/search/search_delegate.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context);

    print(moviesProvider.onDisplayMovies);

    return Scaffold(
      extendBodyBehindAppBar: true,

      floatingActionButton: SpeedDial( // libreria que ayuda a crear animaciones con los floattingactionbuttons.
        animatedIcon: AnimatedIcons.menu_close,
        backgroundColor: Colors.redAccent,
        overlayColor: Colors.black,
        overlayOpacity: 0.8,
        children: [
          SpeedDialChild(
            child: Icon( Icons.search ),
            label: 'Buscar una película',
            onTap: () => showSearch(context: context, delegate: MovieSearchDelegate())
          ),
          SpeedDialChild(
            child: Icon( Icons.settings ),
            label: 'Configuraciones',
            onTap: () => Navigator.pushNamed(context, 'settings')
          )
        ],
      ),

      /*appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => showSearch(context: context, delegate: MovieSearchDelegate()),
            icon: Icon(Icons.search_outlined, color: Colors.black, size: 30.0,),
          )
        ],
        backgroundColor: Colors.transparent,
      ),*/
      body: SingleChildScrollView(
        child: Column(
          children: [

            SizedBox(height: 65.0,),

            // Titulos principales:

            CardSwiper( movies: moviesProvider.onDisplayMovies, ),

            SizedBox(height: 38.0,),

            // Slider de peliculas:

            MovieSlider( 
              movies: moviesProvider.popularMovies,
              onNextPage: () => moviesProvider.getPopularMovies(),
              title: 'Populares',
            ),
          ],
        ),
      ),
    );
  }
}