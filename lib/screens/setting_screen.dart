
import 'package:flutter/material.dart';
import 'package:peliculasapp/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final themeMovieProvider = Provider.of<MoviesProvider>(context);
    return Scaffold(
      body: Center(
        child: Switch.adaptive(
          value: themeMovieProvider.isDarkMode,
          onChanged: ( value ) {
            final provider = Provider.of<MoviesProvider>(context, listen: false);
             provider.changeMyTheme( value );
             print(themeMovieProvider.getTextColor());
          },
        ),
      ),
    );
  }
}