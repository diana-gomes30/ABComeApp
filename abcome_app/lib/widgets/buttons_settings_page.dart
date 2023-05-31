import 'package:abcome_app/models/mandate.dart';
import 'package:abcome_app/utils/constants.dart';
import 'package:flutter/material.dart';

class ButtonsSettingsPage extends StatelessWidget {
  const ButtonsSettingsPage({
    Key? key,
    required this.currentMandate,
    required this.onChangePresidentTreasurer,
    required this.onChangePersonLimit,
    this.iconSize = 40,
    this.fontSize = 20,
    this.leftPadding = 50,
    this.rightPadding = 70,
    this.hintTextSize = 16,
  }) : super(key: key);

  final Mandate?currentMandate;
  final VoidCallback onChangePresidentTreasurer;
  final VoidCallback onChangePersonLimit;
  final double iconSize;
  final double fontSize;
  final double leftPadding;
  final double rightPadding;
  final double hintTextSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(left: leftPadding),
          width: double.infinity,
          child: TextButton(
            onPressed: onChangePresidentTreasurer,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Icon(
                    Icons.arrow_right_sharp,
                    size: iconSize,
                    color: kPrimaryColor,
                  ),
                  Text(
                    'Alterar o Presidente e/ou Tesoureiro',
                    style: TextStyle(
                      fontSize: fontSize,
                      color: kPrimaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(left: leftPadding),
          child: TextButton(
            onPressed: onChangePersonLimit,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.arrow_right_sharp,
                  size: iconSize,
                  color: kPrimaryColor,
                ),
                Text(
                  'Alterar limite de membros do grupo',
                  style: TextStyle(
                    fontSize: fontSize,
                    color: kPrimaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
