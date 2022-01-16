import 'package:flutter/material.dart';
import 'package:plus_movies/core/presentation/styles/colors.dart';

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
