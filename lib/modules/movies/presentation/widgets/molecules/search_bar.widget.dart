import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:plus_movies/core/presentation/styles/colors.dart';
import 'package:plus_movies/modules/movies/domain/entities/entities.dart';
import 'package:plus_movies/modules/movies/presentation/pages/movie_details.page.dart';
import 'package:plus_movies/modules/movies/presentation/stores/movie_list.store.dart';

class SearchBarMolecule extends StatelessWidget {
  final MovieListStore store;
  const SearchBarMolecule({
    Key? key,
    required this.store,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TypeAheadField(
      minCharsForSuggestions: 2,
      suggestionsBoxDecoration: SuggestionsBoxDecoration(
        borderRadius: BorderRadius.circular(
          6,
        ),
        elevation: .5,
      ),
      textFieldConfiguration: TextFieldConfiguration(
        style: const TextStyle(
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          label: const Text("Pesquise filmes"),
          labelStyle: const TextStyle(
            fontWeight: FontWeight.w400,
          ),
          isDense: true,
          prefixIcon: GestureDetector(
            child: const Icon(
              Icons.search,
              size: 18,
            ),
          ),
          prefixIconConstraints: const BoxConstraints(
            minWidth: 38,
            minHeight: 28,
          ),
        ),
      ),
      noItemsFoundBuilder: (context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: gray07,
            borderRadius: BorderRadius.circular(
              6,
            ),
          ),
          child: const Text("Filme não encontrado"),
        );
      },
      itemBuilder: (BuildContext context, Movie movie) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 1),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: gray07,
              borderRadius: BorderRadius.circular(
                6,
              ),
            ),
            child: Text(movie.title),
          ),
        );
      },
      onSuggestionSelected: (Movie movie) {
        Navigator.of(context).pushNamed(
          MovieDetailsPage.routeName,
          arguments: movie,
        );
      },
      suggestionsCallback: (pattern) {
        return store.filteredMovies.where((element) =>
            element.title.toLowerCase().contains(pattern.toLowerCase()));
      },
    );
  }
}
