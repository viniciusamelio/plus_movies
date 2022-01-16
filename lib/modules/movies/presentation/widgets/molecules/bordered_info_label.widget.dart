import 'package:flutter/material.dart';
import 'package:plus_movies/core/presentation/styles/colors.dart';

class BorderedInfoLabelMolecule extends StatelessWidget {
  final String value;
  const BorderedInfoLabelMolecule({
    Key? key,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 10,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            5,
          ),
          border: Border.all(
            color: gray07,
            width: 1,
          )),
      child: Text(
        value,
        style: const TextStyle(
          color: gray02,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
