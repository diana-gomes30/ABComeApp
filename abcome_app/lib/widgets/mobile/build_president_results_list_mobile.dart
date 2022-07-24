import 'package:abcome_app/models/person.dart';
import 'package:abcome_app/models/statistic.dart';
import 'package:abcome_app/utils/constants.dart';
import 'package:abcome_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

ListView buildPresidentResultsListMobile(
  int lastPresidentPosition,
  List<Statistic> statisticsPresidentList,
  List<Person> personsList,
  int numPersons,
) {
  return ListView.builder(
    physics: const NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: statisticsPresidentList.length,
    itemBuilder: (context, index) {
      int position = 0;
      if (index > 0 &&
          statisticsPresidentList[index].presidentNumVotes ==
              statisticsPresidentList[index - 1].presidentNumVotes) {
        position = lastPresidentPosition;
      } else {
        position = lastPresidentPosition + 1;
        lastPresidentPosition = position;
      }

      Person? person;
      for (Person p in personsList) {
        if (p.id == statisticsPresidentList[index].personId) {
          person = p.copy();
        }
      }

      double percentageNum =
          (statisticsPresidentList[index].presidentNumVotes / numPersons) * 100;

      return Container(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.07),
        child: Card(
          child: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(right: 15),
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
                    Text(
                      person.name,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                      child: Center(
                        child: Text(
                          '$positionº',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.65,
                      padding: const EdgeInsets.only(top: 15, bottom: 15),
                      child: LinearPercentIndicator(
                        animation: true,
                        lineHeight: 20.0,
                        animationDuration: 3000,
                        percent: percentageNum / 100,
                        trailing: Text(
                            '(${statisticsPresidentList[index].presidentNumVotes} Votos)'),
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
          ),
        ),
      );
    },
  );
}
