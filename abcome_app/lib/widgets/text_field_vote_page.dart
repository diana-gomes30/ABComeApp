import 'package:abcome_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TextFieldVotePage extends StatelessWidget {
  const TextFieldVotePage({
    Key? key,
    required this.onClickPerson,
    required this.personController,
    this.width = 0.5,
    this.type = 0,
  }) : super(key: key);

  final VoidCallback onClickPerson;
  final TextEditingController personController;
  final double width;
  final int type;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * width,
      margin: const EdgeInsets.symmetric(vertical: 15.0),
      padding: const EdgeInsets.symmetric(
        vertical: 5.0,
      ),
      decoration: textBoxDecoration.copyWith(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: GestureDetector(
        onTap: onClickPerson,
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                enabled: false,
                controller: personController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: type == 1
                    ? 'Selecione o presidente'
                    : type == 2
                      ? 'Selecione o tesoureiro'
                      : 'Selecione o seu nome',
                  hintStyle: TextStyle(
                    fontSize: 16.0,
                    color: kPrimaryColor.withOpacity(0.5),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 15.0),
                  prefixIcon: const Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 20.0),
                    child: Icon(
                      FontAwesomeIcons.user,
                      color: kPrimaryColor,
                      size: 25,
                    ),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Icon(Icons.arrow_drop_down),
            ),
          ],
        ),
      ),
    );
  }
}