import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoaderMolecule extends StatelessWidget {
  const LoaderMolecule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height * .6,
        alignment: Alignment.center,
        child: Center(
          child: Lottie.asset(
            "assets/animations/movie-loader.json",
            height: 120,
          ),
        ),
      ),
    );
  }
}
