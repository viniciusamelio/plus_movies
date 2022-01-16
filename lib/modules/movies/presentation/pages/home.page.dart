import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:plus_movies/core/presentation/styles/colors.dart';
import 'package:plus_movies/modules/movies/presentation/presenters/movie_list.presenter.dart';
import 'package:plus_movies/modules/movies/presentation/stores/movie_list.store.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  late final MovieListPresenter _movieListPresenter;
  late final TextEditingController _searchBarController;

  @override
  void initState() {
    _movieListPresenter = MovieListStore();
    _searchBarController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 18,
            horizontal: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Filmes",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: gray01,
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  SearchBarMolecule(
                    controller: _searchBarController,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
              Observer(builder: (_) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GenreLabelMolecule(
                      title: "Ação",
                      onTap: () => _movieListPresenter.selectGenre(0),
                      isSelected: _movieListPresenter.selectedGenreIndex == 0,
                    ),
                    GenreLabelMolecule(
                      title: "Aventura",
                      onTap: () => _movieListPresenter.selectGenre(1),
                      isSelected: _movieListPresenter.selectedGenreIndex == 1,
                    ),
                    GenreLabelMolecule(
                      title: "Fantasia",
                      onTap: () => _movieListPresenter.selectGenre(2),
                      isSelected: _movieListPresenter.selectedGenreIndex == 2,
                    ),
                    GenreLabelMolecule(
                      title: "Comédia",
                      onTap: () => _movieListPresenter.selectGenre(3),
                      isSelected: _movieListPresenter.selectedGenreIndex == 3,
                    ),
                  ],
                );
              }),
              const SizedBox(
                height: 40,
              ),
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  primary: true,
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: MoviePosterMolecule(),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: MoviePosterMolecule(),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: MoviePosterMolecule(),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class SearchBarMolecule extends StatelessWidget {
  final TextEditingController controller;
  const SearchBarMolecule({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
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
    );
  }
}

class MoviePosterMolecule extends StatelessWidget {
  const MoviePosterMolecule({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .62,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: const DecorationImage(
          fit: BoxFit.fill,
          image: NetworkImage(
            "https://i.pinimg.com/originals/ab/9b/85/ab9b85275c92f13d087079c47fe00899.jpg",
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 162,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                colors: [
                  Colors.black,
                  Colors.black.withOpacity(.4),
                  Colors.transparent,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 12,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Text(
                    "Alita: Anjo de Combate",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    "Ação - Aventura",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class GenreLabelMolecule extends StatelessWidget {
  final String title;
  final Function onTap;
  final bool isSelected;
  const GenreLabelMolecule(
      {Key? key,
      required this.title,
      required this.onTap,
      required this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 12,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(26),
          border: Border.all(
            color: gray08,
          ),
          color: isSelected
              ? Theme.of(context).colorScheme.secondary
              : Colors.white,
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: isSelected
                ? Theme.of(context).colorScheme.onSecondary
                : Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
    );
  }
}
