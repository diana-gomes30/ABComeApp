import 'package:abcome_app/models/person.dart';
import 'package:abcome_app/utils/constants.dart';
import 'package:abcome_app/widgets/person_image_settings_page.dart';
import 'package:flutter/material.dart';

class MandatePersons extends StatelessWidget {
  const MandatePersons({
    Key? key,
    required this.currentPresident,
    required this.currentTreasurer,
    this.imageSize = 175.0,
    this.fontSize = 25,
  }) : super(key: key);

  final Person? currentPresident;
  final Person? currentTreasurer;
  final double imageSize;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: Text(
                  'Presidente',
                  style: TextStyle(
                    fontSize: fontSize,
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              PersonImage(
                imagePath: currentPresident != null
                    ? currentPresident!.image
                    : '',
                size: imageSize,
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 20, top: 20),
                child: Text(
                  currentPresident != null
                      ? currentPresident!.name
                      : 'Presidente não definido',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: fontSize,
                    color: kPrimaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: Text(
                  'Tesoureiro',
                  style: TextStyle(
                    fontSize: fontSize,
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              PersonImage(
                imagePath: currentTreasurer != null
                  ? currentTreasurer!.image
                  : '',
                size: imageSize,
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 20, top: 20),
                child: Text(
                  currentTreasurer != null
                      ? currentTreasurer!.name
                      : 'Tesoureiro não definido',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: fontSize,
                    color: kPrimaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
