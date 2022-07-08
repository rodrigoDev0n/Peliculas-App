import 'package:flutter/material.dart';
import 'package:peliculasapp/providers/movies_provider.dart';
import 'package:peliculasapp/screens/screens.dart';
import 'package:provider/provider.dart';
import 'package:flutter/widgets.dart';


void main() {
  runApp(AppState());
}

// Mantiene el estado de nuestra aplicación:
class AppState extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ( _ ) => MoviesProvider(), lazy: false, ),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final myThemeProvider = Provider.of<MoviesProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Peliculas',
      initialRoute: 'home',
      routes: {
        'home': ( _ ) => HomeScreen(),
        'details': ( _ ) => DetailsScreen(),
        'settings': ( _ ) => SettingScreen()
      },
      themeMode: myThemeProvider.themeMode,  
      theme: MyThemes.lightTheme,
      darkTheme: MyThemes.darkTheme,
    );
  }
}