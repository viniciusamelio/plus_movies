import 'package:flutter/material.dart';

class SearchBarMolecule extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  const SearchBarMolecule({
    Key? key,
    required this.controller,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
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
