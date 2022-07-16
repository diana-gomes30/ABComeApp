import 'package:abcome_app/utils/constants.dart';
import 'package:flutter/material.dart';

class StartPollButton extends StatelessWidget {
  const StartPollButton({
    Key? key,
    required this.onClickCreatePoll,
  }) : super(key: key);

  final VoidCallback onClickCreatePoll;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      fit: FlexFit.loose,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextButton(
            onPressed: onClickCreatePoll,
            child: const Text(
              'Iniciar Votação',
              style: TextStyle(
                color: kWhiteColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}