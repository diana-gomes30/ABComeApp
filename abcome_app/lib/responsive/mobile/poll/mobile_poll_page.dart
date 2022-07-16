import 'package:abcome_app/models/person.dart';
import 'package:abcome_app/widgets/custom_divider.dart';
import 'package:abcome_app/widgets/person_card_poll.dart';
import 'package:abcome_app/widgets/start_poll_button.dart';
import 'package:abcome_app/widgets/title_poll_page.dart';
import 'package:flutter/material.dart';

class MobilePollPage extends StatelessWidget {
  const MobilePollPage({
    Key? key,
    required this.personsList,
    required this.onClickCardPerson,
    required this.onChangeCardValue,
    required this.onClickCreatePoll,
  }) : super(key: key);

  final List<Person> personsList;
  final Function(int index) onClickCardPerson;
  final Function(int index, bool newValue) onChangeCardValue;
  final VoidCallback onClickCreatePoll;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TitlePollPage(fontSize: 18),
        const CustomDivider(),
        Flexible(
          flex: 6,
          fit: FlexFit.loose,
          child: Container(
            padding: const EdgeInsets.all(15.0),
            child: ListView.builder(
              itemCount: personsList.length,
              itemBuilder: (BuildContext context, int index) {
                return PersonCardPoll(
                  index: index,
                  personsList: personsList,
                  onClickCardPerson: (i) => onClickCardPerson(i),
                  onChangeCardValue: (index, newValue) =>
                      onChangeCardValue(index, newValue),
                );
              },
            ),
          ),
        ),
        StartPollButton(onClickCreatePoll: onClickCreatePoll),
      ],
    );
  }
}
