import 'package:abcome_app/models/mandate.dart';
import 'package:abcome_app/models/person.dart';
import 'package:abcome_app/models/poll.dart';
import 'package:abcome_app/widgets/buttons_settings_page.dart';
import 'package:abcome_app/widgets/custom_divider.dart';
import 'package:abcome_app/widgets/mandate_persons.dart';
import 'package:abcome_app/widgets/title_settings_page.dart';
import 'package:flutter/material.dart';

class MobileSettingsPage extends StatelessWidget {
  const MobileSettingsPage({
    Key? key,
    required this.currentPoll,
    required this.currentPresident,
    required this.currentTreasurer,
    required this.currentMandate,
    required this.onChangePresidentTreasurer,
    required this.onChangePersonLimit,
  }) : super(key: key);

  final Poll? currentPoll;
  final Person? currentPresident;
  final Person? currentTreasurer;
  final Mandate? currentMandate;
  final VoidCallback onChangePresidentTreasurer;
  final VoidCallback onChangePersonLimit;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            TitleSettingsPage(
              currentPoll: currentPoll,
              fontSize: 24,
            ),
            MandatePersons(
              currentPresident: currentPresident,
              currentTreasurer: currentTreasurer,
              imageSize: 100.0,
              fontSize: 18,
            ),
            const CustomDivider(
              start: 15,
              end: 15,
            ),
            ButtonsSettingsPage(
              currentMandate: currentMandate,
              onChangePresidentTreasurer: onChangePresidentTreasurer,
              onChangePersonLimit: onChangePersonLimit,
              iconSize: 20,
              fontSize: 16,
              leftPadding: 10,
              rightPadding: 0,
              hintTextSize: 10,
            ),
          ],
        ),
      ),
    );
  }
}