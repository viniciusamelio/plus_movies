import 'package:flutter/material.dart';
import 'package:plus_movies/core/presentation/styles/colors.dart';

class ErrorViewMolecule extends StatelessWidget {
  final String message;
  const ErrorViewMolecule({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height * .6,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/movie-error.png",
                height: 200,
              ),
              const Text(
                "Oopss..",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: gray01,
                ),
              ),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: gray02,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
