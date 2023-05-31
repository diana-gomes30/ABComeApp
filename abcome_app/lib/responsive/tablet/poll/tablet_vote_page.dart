import 'package:abcome_app/widgets/confirm_vote_button.dart';
import 'package:abcome_app/widgets/text_field_vote_page.dart';
import 'package:abcome_app/widgets/title_vote_page.dart';
import 'package:flutter/material.dart';

class TabletVotePage extends StatelessWidget {
  const TabletVotePage({
    Key? key,
    required this.year,
    required this.personController,
    required this.onClickPerson,
    required this.presidentController,
    required this.onClickPresident,
    required this.treasurerController,
    required this.onClickTreasurer,
    required this.onClickConfirmVote,
    required this.onClickCancelPoll,
  }) : super(key: key);

  final int year;

  final TextEditingController personController;
  final VoidCallback onClickPerson;

  final TextEditingController presidentController;
  final VoidCallback onClickPresident;

  final TextEditingController treasurerController;
  final VoidCallback onClickTreasurer;

  final VoidCallback onClickConfirmVote;
  final VoidCallback onClickCancelPoll;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TitleVotePage(
                year: year,
              ),
              TextFieldVotePage(
                onClickPerson: onClickPerson,
                personController: personController,
              ),
              TextFieldVotePage(
                onClickPerson: onClickPresident,
                personController: presidentController,
                type: 1,
              ),
              TextFieldVotePage(
                onClickPerson: onClickTreasurer,
                personController: treasurerController,
                type: 2,
              ),
              ConfirmVoteButton(
                onClickConfirmVote: onClickConfirmVote,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
