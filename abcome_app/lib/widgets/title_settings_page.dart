import 'package:abcome_app/models/poll.dart';
import 'package:abcome_app/utils/constants.dart';
import 'package:flutter/material.dart';

class TitleSettingsPage extends StatelessWidget {
  const TitleSettingsPage({
    Key? key,
    required this.currentPoll,
    this.fontSize = 25,
  }) : super(key: key);

  final Poll? currentPoll;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      child: Text(
        currentPoll != null
            ? 'Ano de Mandato: ${currentPoll!.year}/${(currentPoll!.year) + 1}'
            : 'Ano de Mandato: 20xx/20xx',
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: kPrimaryColor,
        ),
      ),
    );
  }
}
