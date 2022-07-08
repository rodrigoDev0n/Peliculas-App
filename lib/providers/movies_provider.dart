// provee de información a nuesta aplicación:
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculasapp/models/models.dart';
import 'package:peliculasapp/models/search_response.dart';

class MoviesProvider extends ChangeNotifier{

  String _apiKey = '2df1cb5a93db0802f57b5eced3e658b3';
  String _baseUrl = 'api.themoviedb.org';
  String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  // Servira para encontrar los actores por el id de la pelicula:
  Map<int, List<Cast>> moviesCast = {};
 
  int _popularPage = 0;


  MoviesProvider() {
    print('Movies Provider inicializado');

    this.getOnDisplayMovies();
    this.getPopularMovies();
  }

  Future<String> _getJsonData( String endpoint, [int page = 1]) async {
    final url = Uri.https( _baseUrl , endpoint, {
      'api_key': _apiKey,
      'language': _language,
      'page': '1'
    });    

    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovies() async {

    // Await the http get response, then decode the json-formatted response.
    var data = await _getJsonData('/3/movie/now_playing');
    final nowPlayingResponse = NowPlayingResponse.fromJson(data);

    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();
  }

  getPopularMovies() async {

    // Incrementa la pagina de nuestro scroll de las peliculas populares:
    _popularPage++;

    // Await the http get response, then decode the json-formatted response.
    var data = await _getJsonData('/3/movie/popular', 1);
    final popularResponse = PopularMovies.fromJson(data);

    // En este caso se destructuran los datos de las peliculas populares:
    popularMovies = [...popularMovies, ...popularResponse.results];
    notifyListeners();

  }

  Future<List<Cast>> getMovieCast( int movieId ) async {

    // Mostrar datos cargados en memoria de la aplicación:
    if( moviesCast.containsKey(movieId) ) return moviesCast[movieId]!;

    final data = await this._getJsonData('/3/movie/${movieId}/credits');
    final castMovies = CastMovies.fromJson( data );

    moviesCast[movieId] = castMovies.cast;

    print(moviesCast);  
    return castMovies.cast; 

  }

  Future<List<Movie>> searchMovie( String query ) async {

    final url = Uri.https( _baseUrl , '/3/search/movie', {
      'api_key': _apiKey,
      'language': _language,
      'query': query
    });

    final response = await http.get(url);
    final searchresponse =  SearchResponse.fromJson(response.body);

    return searchresponse.results;
  }



  // Modificación de los temas de la aplicación:
  ThemeMode themeMode = ThemeMode.dark;
  bool get isDarkMode => themeMode == ThemeMode.dark;

  void changeMyTheme( bool isOn ) {

    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;

    notifyListeners();

  }

  // Define los colores que tendran los textos en base al tema:
  Color getTextColor() {

    // Define los colores de los texts:
    Color colorText;

    themeMode == ThemeMode.dark
      ? colorText = MyThemes.colorTextLight
      : colorText = MyThemes.colorTextDark;

    return colorText;
  }

}

// temas custom para la app:

class MyThemes {
    static final darkTheme = ThemeData(
      scaffoldBackgroundColor: Colors.grey.shade900,
    );

    static final lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      colorScheme: ColorScheme.light()
    );

    // Colores de los textos:
    static final colorTextLight = Colors.white;
    static final colorTextDark = Colors.black;

    // TODO: modificar los colores del buscador

}