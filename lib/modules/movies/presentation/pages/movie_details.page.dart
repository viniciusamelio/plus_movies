import 'package:flutter/material.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:plus_movies/core/presentation/styles/colors.dart';
import 'package:plus_movies/modules/movies/domain/entities/entities.dart';
import 'package:plus_movies/modules/movies/presentation/widgets/molecules/bordered_info_label.widget.dart';
import 'package:plus_movies/modules/movies/presentation/widgets/molecules/molecules.dart';

class MovieDetailsPage extends StatefulWidget {
  static String routeName = "/movie/details";
  const MovieDetailsPage({Key? key}) : super(key: key);

  @override
  _MovieDetailsPageState createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  late final Movie movie;

  @override
  void didChangeDependencies() {
    movie = ModalRoute.of(context)!.settings.arguments as Movie;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    String director = _getDirector();
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            vertical: 26,
            horizontal: 20,
          ),
          child: Column(
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: BackButtonMolecule(),
              ),
              const SizedBox(
                height: 56,
              ),
              MoviePosterMolecule(
                movie: movie,
                mini: true,
              ),
              const SizedBox(
                height: 32,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    movie.voteAverage.toString(),
                    style: const TextStyle(
                      color: darkGreen01,
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                    ),
                  ),
                  const Text(
                    " / 10",
                    style: TextStyle(
                      color: gray03,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 32,
              ),
              Text(
                movie.title,
                style: const TextStyle(
                  color: gray01,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  const Text(
                    "Título Original: ",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: gray02,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    movie.originalTitle,
                    style: const TextStyle(
                      color: gray02,
                      fontSize: 14,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 32,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FilledInfoLabelMolecule(
                    title: "Ano",
                    value: movie.releaseDate.split("-")[0],
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  FilledInfoLabelMolecule(
                    title: "Duração",
                    value: durationToString(
                      movie.runtime!,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Wrap(
                alignment: WrapAlignment.center,
                direction: Axis.horizontal,
                children: movie.genres
                    .map(
                      (e) => Padding(
                        padding: const EdgeInsets.only(
                          left: 8.0,
                        ),
                        child: BorderedInfoLabelMolecule(
                          value: e.name,
                        ),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(
                height: 56,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    "Descrição",
                    style: TextStyle(
                      fontSize: 14,
                      color: gray02,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    movie.overview,
                    style: const TextStyle(
                      color: gray01,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: FilledInfoLabelMolecule(
                      title: "Orçamento",
                      value: MoneyFormatter(
                        amount: movie.revenue.toDouble(),
                      ).output.symbolOnLeft,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: FilledInfoLabelMolecule(
                      title: "Produtora",
                      value: movie.productionCompanies[0].name,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: director.isNotEmpty
                        ? [
                            const SizedBox(
                              height: 40,
                            ),
                            const Text(
                              "Diretor",
                              style: TextStyle(
                                fontSize: 14,
                                color: gray02,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              director,
                              style: const TextStyle(
                                color: gray01,
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                          ]
                        : [],
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  const Text(
                    "Elenco",
                    style: TextStyle(
                      fontSize: 14,
                      color: gray02,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    movie.cast
                        .where((element) => element.department == "Acting")
                        .map((e) => e.name)
                        .toString()
                        .replaceAll("(", "")
                        .replaceAll(")", "")
                        .replaceAll("...,", ""),
                    style: const TextStyle(
                      color: gray01,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(
                    height: 90,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  String durationToString(int minutes) {
    var d = Duration(minutes: minutes);
    List<String> parts = d.toString().split(':');
    return '${parts[0].padLeft(1, '0')}h ${parts[1].padLeft(2, '0')} min';
  }

  String _getDirector() {
    return movie.cast
        .where(
          (element) => element.department == "Directing",
        )
        .map((e) => e.name)
        .toString()
        .replaceAll("(", "")
        .replaceAll(")", "");
  }
}

class FilledInfoLabelMolecule extends StatelessWidget {
  final String title;
  final String value;
  const FilledInfoLabelMolecule({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      decoration: BoxDecoration(
        color: gray08,
        borderRadius: BorderRadius.circular(
          5,
        ),
      ),
      child: Row(
        children: [
          Text(
            "$title: ",
            style: const TextStyle(
              color: gray03,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: gray01,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class BackButtonMolecule extends StatelessWidget {
  const BackButtonMolecule({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      icon: const Icon(
        Icons.arrow_back,
        color: gray02,
      ),
      onPressed: () => Navigator.of(context).pop(),
      style: ButtonStyle(
          backgroundColor: MaterialStateColor.resolveWith(
            (states) => Colors.white,
          ),
          padding: MaterialStateProperty.resolveWith(
            (states) => const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
              100,
            )),
          )),
      label: const Text(
        "Voltar",
        style: TextStyle(
          color: gray02,
          fontSize: 12,
        ),
      ),
    );
  }
}
