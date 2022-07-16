import 'package:abcome_app/utils/constants.dart';
import 'package:flutter/material.dart';

class TitlePollPage extends StatelessWidget {
  const TitlePollPage({
    Key? key,
    this.fontSize = 24,
  }) : super(key: key);

  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      fit: FlexFit.loose,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            'Selecione os membros que irão votar',
            style: TextStyle(
              fontSize: fontSize,
              color: kPrimaryColor,
            ),
          ),
        ),
      ),
    );
  }
}