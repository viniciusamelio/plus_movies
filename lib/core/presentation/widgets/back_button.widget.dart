import 'package:flutter/material.dart';
import 'package:plus_movies/core/presentation/styles/colors.dart';

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
