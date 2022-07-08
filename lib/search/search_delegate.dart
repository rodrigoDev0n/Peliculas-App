import 'package:flutter/material.dart';
import 'package:peliculasapp/providers/movies_provider.dart';
import 'package:peliculasapp/models/models.dart';
import 'package:provider/provider.dart';

class MovieSearchDelegate extends SearchDelegate {
  
  @override
  String get searchFieldLabel => 'Busca alguna película';

  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildAct
    return [
      IconButton(
        onPressed: () => query = '', 
        icon: Icon( Icons.clear ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      onPressed: () {
        close(context, null);
      }, 
      icon: Icon( Icons.arrow_back ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Text('buildResults');
  }

  Widget _EmptyContainer() {
    return Container(
        child: Center(
          child: Icon( Icons.search_outlined, color: Colors.black38, size: 100, ),
        ),
      );
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    final myThemeProvider = Provider.of<MoviesProvider>(context);

    if( query.isEmpty ) {
      return Container(
        child: Center(
          child: Icon( Icons.search_outlined, color: myThemeProvider.getTextColor(), size: 100, ),
        ),
      );
    }

    final moviesProvider = Provider.of<MoviesProvider>(context);

    return FutureBuilder(
      future: moviesProvider.searchMovie(query),
      builder: ( _, AsyncSnapshot<List<Movie>> snapshot ) {

        if( !snapshot.hasData ) return _EmptyContainer();

        final movies = snapshot.data!;

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: ( _, int index ) => _MovieItem( movies[index] ),
        );
      }
    );
  }
}

class _MovieItem extends StatelessWidget {

  final Movie movie;

  _MovieItem( this.movie );

  @override
  Widget build(BuildContext context) {

    movie.heroId = 'search-${ movie.id }';
    final myThemeProvider = Provider.of<MoviesProvider>(context);

    return Hero(
      tag: movie.heroId!,
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, 'details', arguments: movie),
        child: Container(
          child: ListTile(
            leading: FadeInImage(
              placeholder: AssetImage( 'assets/no-image.jpg' ), 
              image: NetworkImage( movie.fullPosterImg ),
            ),
            title: Text(
               movie.title,
               style: TextStyle( color: myThemeProvider.getTextColor() ),
            ),
          ),
        ),
      ),
    );
  }
}