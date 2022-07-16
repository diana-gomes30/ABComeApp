import 'package:abcome_app/utils/constants.dart';
import 'package:flutter/material.dart';

class ConfirmVoteButton extends StatelessWidget {
  const ConfirmVoteButton({
    Key? key,
    required this.onClickConfirmVote,
  }) : super(key: key);

  final VoidCallback onClickConfirmVote;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(30),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
        onPressed: onClickConfirmVote,
        child: const Text(
          'Confirmar',
          style: TextStyle(fontSize: 20, color: kWhiteColor),
        ),
      ),
    );
  }
}
