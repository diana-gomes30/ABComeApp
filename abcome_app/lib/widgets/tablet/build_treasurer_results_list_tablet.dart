import 'package:abcome_app/models/person.dart';
import 'package:abcome_app/models/statistic.dart';
import 'package:abcome_app/utils/constants.dart';
import 'package:abcome_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

ListView buildTreasurerResultsListTablet(
    int lastTreasurerPosition,
    List<Statistic> statisticsTreasurerList,
    List<Person> personsList,
    int numPersons,
    ) {
  return ListView.builder(
    physics: const NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: statisticsTreasurerList.length,
    itemBuilder: (context, index) {
      int position = 0;
      if (index > 0 &&
          statisticsTreasurerList[index].treasurerNumVotes ==
              statisticsTreasurerList[index - 1].treasurerNumVotes) {
        position = lastTreasurerPosition;
      } else {
        position = lastTreasurerPosition + 1;
        lastTreasurerPosition = position;
      }

      Person? person;
      for (Person p in personsList) {
        if (p.id == statisticsTreasurerList[index].personId) {
          person = p.copy();
        }
      }

      double percentageNum =
          (statisticsTreasurerList[index].treasurerNumVotes / numPersons) *
              100;

      return Column(
        children: [
          Container(
            padding: const EdgeInsets.only(right: 30, left: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width * 0.065,
                  child: ClipOval(
                    child: Material(
                      color: Colors.transparent,
                      child: person!.image == ''
                          ? const Image(
                        image: AssetImage(
                          kLogoImagePath,
                        ),
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      )
                          : Utils.imageFromBase64String(
                        person.image,
                        width: 50.0,
                        height: 50.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.20,
                  padding: const EdgeInsets.only(top: 15, bottom: 15),
                  child: Text(
                    person.name,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                Text(
                  '$positionº',
                  style: const TextStyle(fontSize: 18),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.50,
                  padding:
                  const EdgeInsets.only(top: 15, bottom: 15, right: 100),
                  child: LinearPercentIndicator(
                    animation: true,
                    lineHeight: 20.0,
                    animationDuration: 3000,
                    percent: percentageNum / 100,
                    trailing: Text(
                        '(${statisticsTreasurerList[index].treasurerNumVotes} Votos)'),
                    center: Text(
                      '${percentageNum.toStringAsFixed(2)}%',
                      style: const TextStyle(
                        color: kWhiteColor,
                      ),
                    ),
                    curve: Curves.easeInOut,
                    barRadius: const Radius.circular(20.0),
                    progressColor: kPrimaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}