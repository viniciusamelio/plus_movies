import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:plus_movies/env.dart';
import 'package:plus_movies/modules/movies/domain/entities/entities.dart';
import 'package:plus_movies/modules/movies/presentation/pages/movie_details.page.dart';

class MoviePosterMolecule extends StatelessWidget {
  final Movie movie;
  final bool mini;
  const MoviePosterMolecule({
    Key? key,
    required this.movie,
    this.mini = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String movieGenres = _cleanMovieGenresString();
    return GestureDetector(
      onTap: () => !mini
          ? Navigator.of(context).pushNamed(
              MovieDetailsPage.routeName,
              arguments: movie,
            )
          : null,
      child: Center(
        child: Container(
          height: !mini
              ? MediaQuery.of(context).size.height * .62
              : MediaQuery.of(context).size.height * .45,
          width: !mini
              ? MediaQuery.of(context).size.width
              : MediaQuery.of(context).size.width * .6,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              fit: BoxFit.fill,
              image: CachedNetworkImageProvider(
                "$movieDBImageBaseUrl${movie.posterPath}",
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
                child: !mini
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              movie.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Text(
                              movieGenres,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(
                              height: 32,
                            )
                          ],
                        ),
                      )
                    : Container(),
              )
            ],
          ),
        ),
      ),
    );
  }

  String _cleanMovieGenresString() {
    String movieGenres = movie.genres
        .map((e) => e.name + " - ")
        .toString()
        .replaceAll("(", "")
        .replaceAll(")", "")
        .replaceAll(",", "");
    movieGenres = movieGenres.substring(0, movieGenres.length - 2);
    return movieGenres;
  }
}
