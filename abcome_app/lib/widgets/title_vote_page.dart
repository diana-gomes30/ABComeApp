import 'package:abcome_app/utils/constants.dart';
import 'package:flutter/material.dart';

class TitleVotePage extends StatelessWidget {
  const TitleVotePage({
    Key? key,
    required this.year,
    this.size = 30,
  }) : super(key: key);

  final int year;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      child: Text(
        'Votação $year',
        style: TextStyle(
          fontSize: size,
          color: kPrimaryColor,
        ),
      ),
    );
  }
}