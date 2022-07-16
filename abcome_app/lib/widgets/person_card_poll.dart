import 'package:abcome_app/models/person.dart';
import 'package:abcome_app/utils/constants.dart';
import 'package:abcome_app/utils/utils.dart';
import 'package:flutter/material.dart';

class PersonCardPoll extends StatelessWidget {
  const PersonCardPoll({
    Key? key,
    required this.index,
    required this.personsList,
    required this.onClickCardPerson,
    required this.onChangeCardValue,
  }) : super(key: key);

  final int index;
  final List<Person> personsList;
  final Function(int index) onClickCardPerson;
  final Function(int index, bool newValue) onChangeCardValue;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClickCardPerson(index),
      child: SizedBox(
        height: 100,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CheckboxListTile(
                secondary: personsList[index].image == ''
                    ? const Image(
                        image: AssetImage(kLogoImagePath),
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      )
                    : Utils.imageFromBase64String(
                  personsList[index].image,
                        width: 50.0,
                        height: 50.0,
                        fit: BoxFit.cover,
                      ),
                activeColor: kPrimaryColor,
                dense: true,
                //font change
                title: Text(
                  personsList[index].name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
                value: personsList[index].isVoting == 0 ? false : true,
                onChanged: (newValue) => onChangeCardValue(index, newValue!),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
