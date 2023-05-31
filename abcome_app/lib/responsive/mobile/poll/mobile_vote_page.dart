import 'package:abcome_app/widgets/confirm_vote_button.dart';
import 'package:abcome_app/widgets/text_field_vote_page.dart';
import 'package:abcome_app/widgets/title_vote_page.dart';
import 'package:flutter/material.dart';

class MobileVotePage extends StatelessWidget {
  const MobileVotePage({Key? key,
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
                width: 0.80,
              ),
              TextFieldVotePage(
                onClickPerson: onClickPresident,
                personController: presidentController,
                width: 0.80,
                type: 1,
              ),
              TextFieldVotePage(
                onClickPerson: onClickTreasurer,
                personController: treasurerController,
                width: 0.80,
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
