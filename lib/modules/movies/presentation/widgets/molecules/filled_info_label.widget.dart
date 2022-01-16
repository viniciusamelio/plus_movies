import 'package:flutter/material.dart';
import 'package:plus_movies/core/presentation/styles/colors.dart';

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
